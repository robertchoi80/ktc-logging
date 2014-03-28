# rubocop:disable LineLength
#
# CookBook:: ktc-logging
# Recipe:: logstash
#

chef_gem 'chef-rewind'
require 'chef/rewind'

include_recipe 'services'
include_recipe 'ktc-utils'
include_recipe 'logstash::server'

ip = KTC::Network.address 'management'

patterns_dir = node[:logstash][:basedir] + '/'
patterns_dir <<  node[:logstash][:server][:patterns_dir]

es_results = search(:node, node['logging']['elasticsearch_query'])

if es_results.empty?
  es_server_ip = node['logstash']['elasticsearch_ip']
else
  es_server_ip = es_results[0]['ipaddress']
end

cookbook_file "#{patterns_dir}/json" do
  source 'json'
  owner node[:logstash][:user]
  group node[:logstash][:group]
  mode 0644
end

rewind template: "#{node[:logstash][:basedir]}/server/etc/logstash.conf" do
  source 'logstash.conf.erb'
  cookbook 'ktc-logging'
  variables(graphite_server_ip: node[:logstash][:graphite_ip],
            es_server_ip: es_server_ip,
            enable_embedded_es: node[:logstash][:server][:enable_embedded_es],
            es_cluster: node[:logstash][:elasticsearch_cluster],
            splunk_host: node[:logstash][:splunk_host],
            splunk_port: node[:logstash][:splunk_port],
            patterns_dir: patterns_dir
  )
end

# register logstash endpoint #
syslog_port = node[:logstash][:server][:syslog_input_port]
ruby_block 'register logstash endpoint' do
  block do
    member = Services::Member.new node['fqdn'],
                                  service: 'logstash-server',
                                  port: syslog_port,
                                  ip: ip
    member.save

    ep = Services::Endpoint.new 'logstash-server',
                                ip: ip,
                                port: syslog_port
    ep.save
  end
end

# process monitoring and sensu-check config
processes = node[:logging][:logstash_processes]

processes.each do |process|
  sensu_check "check_process_#{process[:name]}" do
    command "check-procs.rb -c 10 -w 10 -C 1 -W 1 -p #{process[:name]}"
    handlers ['default']
    standalone true
    interval 30
  end
end

ktc_collectd_processes 'logstash-processes' do
  input processes
end

##################################
# Rewind index-cleaner resources #
##################################
include_recipe 'logstash::index_cleaner'

base_dir          = File.join(node['logstash']['basedir'], 'index_cleaner')
index_cleaner_bin = File.join(base_dir, 'logstash_index_cleaner.py')
days_to_keep      = node['logstash']['index_cleaner']['days_to_keep']
log_file          = node['logstash']['index_cleaner']['cron']['log_file']

# Fix UCLOUDNG-1383
rewind cookbook_file: index_cleaner_bin do
  cookbook_name 'ktc-logging'
end

# Make it query to remote ES server
rewind cron: 'logstash_index_cleaner' do
  command "#{index_cleaner_bin} --host #{es_server_ip} -d #{days_to_keep} &> #{log_file}"
end
