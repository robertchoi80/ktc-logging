#
# Attributes for mkd_stag environment
#
return unless chef_environment == 'ipc-stage'

include_attribute 'ktc-logging::default'

# Logstash attributes
default[:logstash][:splunk_host] = '10.2.2.81'
default[:logstash][:splunk_port] = '4109'

default[:logstash][:elasticsearch_cluster] = 'es-cluster-ipc-stage'
default[:elasticsearch][:cluster][:name] = 'es-cluster-ipc-stage'

# TODO: This endpoint should be handled with Services library in ktc-rsyslog.
default[:rsyslog][:logstash_server] = 'logstash01-vm.mgmt1.ipc-stage'
