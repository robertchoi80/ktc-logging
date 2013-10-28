# vim: set ft=ruby:
chef_api "https://chefdev.mkd2.ktc", node_name: "cookbook", client_key: ".cookbook.pem"

site :opscode

metadata

group "other" do
  # These are for the jenkins test. #
  cookbook "apt"
  cookbook "java"
  cookbook "ktc-testing"
end
