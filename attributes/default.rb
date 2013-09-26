include_attribute "logstash"
include_attribute "kibana"

# logstash attributes
default[:logstash][:splunk_host] = ''
default[:logstash][:splunk_port] = ''

default[:logstash][:server][:version] = '1.2.1'
default[:logstash][:server][:source_url] =
  'https://download.elasticsearch.org/logstash/logstash/logstash-1.2.1-flatjar.jar'
default[:logstash][:server][:inputs] = [:syslog => { :type=>'syslog', :port=>'5514' }]
default[:logstash][:server][:outputs] = []

default[:logstash][:index_cleaner][:days_to_keep] = 28
default[:logstash][:index_cleaner][:cron][:minute] = '0'
default[:logstash][:index_cleaner][:cron][:hour] = '1'
default[:logstash][:index_cleaner][:cron][:log_file] = '/dev/null'

# kibana attributes
default[:kibana][:webserver] = 'apache'
default[:kibana][:apache][:enable_default_site] = true
