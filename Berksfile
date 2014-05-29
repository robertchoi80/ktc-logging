#
# vim: set ft=ruby:
#

source 'http://cookbooks.mkd2.ktc:26200'

metadata

cookbook "kibana", github: "lusis/chef-kibana"

group "integration" do
  cookbook "etcd"
  cookbook "ktc-testing"
end