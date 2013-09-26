# logstash attributes
override[:logstash][:splunk_host] = ''
override[:logstash][:splunk_port] = ''

override[:logstash][:server][:version] = '1.2.1'
override[:logstash][:server][:source_url] =
  'https://download.elasticsearch.org/logstash/logstash/logstash-1.2.1-flatjar.jar'
override[:logstash][:server][:inputs] = [:syslog => { :type=>'syslog', :port=>'5514' }]
override[:logstash][:server][:outputs] = []

override[:logstash][:index_cleaner][:days_to_keep] = 28
override[:logstash][:index_cleaner][:cron][:minute] = '0'
override[:logstash][:index_cleaner][:cron][:hour] = '1'
override[:logstash][:index_cleaner][:cron][:log_file] = '/dev/null'

# kibana attributes
override[:kibana][:webserver] = 'apache'
override[:kibana][:apache][:enable_override_site] = true
