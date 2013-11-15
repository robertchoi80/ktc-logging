#
# Attributes for mkd_stag environment
#
return unless chef_environment == "mkd_stag"

include_attribute "ktc-logging::default"

# Logstash attributes
default[:logstash][:splunk_host] = '20.0.1.224'
default[:logstash][:splunk_port] = '4109'

default[:logstash][:elasticsearch_cluster] = 'es-cluster-mkd-stag'
default[:elasticsearch][:cluster][:name] = 'es-cluster-mkd-stag'

# TODO: This endpoint should be handled with Services library in ktc-rsyslog.
default[:rsyslog][:logstash_server] = 'logstash01-vm.mkd-stag'
