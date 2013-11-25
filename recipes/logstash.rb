#
# CookBook:: ktc-logging
# Recipe:: logstash
#

chef_gem "chef-rewind"
require 'chef/rewind'

include_recipe "logstash::server"

patterns_dir = node[:logstash][:basedir] + '/'
patterns_dir <<  node[:logstash][:server][:patterns_dir]

cookbook_file "#{patterns_dir}/json" do
  source "json"
  owner node[:logstash][:user]
  group node[:logstash][:group]
  mode 0644
end

rewind :template => "#{node[:logstash][:basedir]}/server/etc/logstash.conf" do
  source "logstash.conf.erb"
  cookbook "ktc-logging"
  variables(:graphite_server_ip => node[:logstash][:graphite_ip],
    :es_server_ip => node[:logstash][:elasticsearch_ip],
    :enable_embedded_es => node[:logstash][:server][:enable_embedded_es],
    :es_cluster => node[:logstash][:elasticsearch_cluster],
    :splunk_host => node[:logstash][:splunk_host],
    :splunk_port => node[:logstash][:splunk_port],
    :patterns_dir => patterns_dir
  )
end
