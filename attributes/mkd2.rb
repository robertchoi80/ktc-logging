#
# Attributes for mkd2 environment
#
return unless chef_environment == "mkd2"

include_attribute "ktc-logging::default"

default[:logstash][:elasticsearch_cluster] = 'es-cluster-mkd2'
default[:elasticsearch][:cluster][:name] = 'es-cluster-mkd2'

# TODO: This endpoint should be handled with Services library in ktc-rsyslog.
default[:rsyslog][:logstash_server] = 'logstash01-vm.mkd2.ktc'
