#
# CookBook:: ktc-logging
# Recipe:: logstash_server
#

chef_gem "chef-rewind"
require 'chef/rewind'

include_recipe "logstash::server"

patterns_dir = node[:logstash][:basedir] + '/'
patterns_dir <<  node[:logstash][:server][:patterns_dir]

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
