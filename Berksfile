# vim: set ft=ruby:
site :opscode

metadata
group "ktc" do
  cookbook 'ktc-rsyslog', github: 'cloudware-cookbooks/ktc-rsyslog'
end

group "other" do
  # These two cookbooks were included just for the jenkins test. #
  cookbook "apt", github: 'opscode-cookbooks/apt'
  cookbook "ubuntu", github: 'opscode-cookbooks/ubuntu'
  cookbook "java"

  cookbook "rsyslog", github: "opscode-cookbooks/rsyslog"
  cookbook "logstash", github: 'lusis/chef-logstash'
  cookbook "kibana", github: 'lusis/chef-kibana'
  cookbook "elasticsearch", github: 'elasticsearch/cookbook-elasticsearch'
end

group "integration" do
  cookbook 'chef-solo-search',
    github: 'edelight/chef-solo-search'
end
