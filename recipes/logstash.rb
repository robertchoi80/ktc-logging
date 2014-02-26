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
ruby_block "register logstash endpoint" do
  block do
    member = Services::Member.new node['fqdn'],
      service: "logstash-server",
      port: node[:logstash][:server][:syslog_input_port]
      ip: ip
    member.save

    ep = Services::Endpoint.new "logstash-server",
      ip: ip,
      port: node[:logstash][:server][:syslog_input_port]
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
