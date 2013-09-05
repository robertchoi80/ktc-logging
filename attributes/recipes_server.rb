#
# Base run list requirements for monitoring
#
default[:logging][:server_recipes] = []

default[:logging][:server_recipes].concat %w{
  logstash::server
  logstash::index_cleaner
  kibana::default
}
