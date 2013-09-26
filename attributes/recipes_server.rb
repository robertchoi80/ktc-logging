#
# Base run list requirements for monitoring
#
default[:logging][:server_recipes] = []

default[:logging][:server_recipes].concat %w{
  ktc-logging::logstash
  logstash::index_cleaner
}
