#
# Attributes for ipc-ng environment
#
return unless chef_environment == 'ipc-prod'

include_attribute 'ktc-logging::default'

# Logstash attributes
default[:logstash][:splunk_host] = '10.2.2.81'
default[:logstash][:splunk_port] = '4109'

default[:logstash][:elasticsearch_cluster] = 'es-cluster-ipc-prod'
default[:elasticsearch][:cluster][:name] = 'es-cluster-ipc-prod'

# TODO: This endpoint should be handled with Services library in ktc-rsyslog.
default[:rsyslog][:logstash_server] = 'logstash01-vm.c50704.mpod1.mgmt-prod.ipc-ng'
