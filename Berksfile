#
# vim: set ft=ruby:
#

chef_api "https://chefdev.mkd2.ktc", node_name: "cookbook", client_key: ".cookbook.pem"

site :opscode

metadata

cookbook "kibana", github: "lusis/chef-kibana"

group "integration" do
  cookbook "etcd"
  cookbook "ktc-testing"
end
