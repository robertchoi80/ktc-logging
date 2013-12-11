chef_gem "chef-rewind"
require 'chef/rewind'

include_recipe "openstack-common::logging"

rewind :template => "/etc/openstack/logging.conf" do
  cookbook_name "ktc-logging"
  notifies :create, "directory[/var/log/openstack]", :immediately
end

directory "/var/log/openstack" do
  owner "root"
  group "root"
  mode 0777
  action :nothing
end

%w{ ceilometer cinder glance horizon keystone nova quantum swift }.each do |file|
  file "/var/log/openstack/#{file}.log" do
    owner "root"
    group "root"
    mode 0777
    action :create_if_missing
  end
end
