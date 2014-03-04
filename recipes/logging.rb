chef_gem 'chef-rewind'
require 'chef/rewind'

include_recipe 'openstack-common::logging'

rewind template: '/etc/openstack/logging.conf' do
  cookbook_name 'ktc-logging'
end
