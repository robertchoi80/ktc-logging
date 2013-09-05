# logstash attributes
override[:logstash][:server][:inputs] = [:syslog => { :type=>'syslog', :port=>'5514' }]
override[:logstash][:index_cleaner][:days_to_keep] = 7
override[:logstash][:index_cleaner][:cron][:minute] = '0'
override[:logstash][:index_cleaner][:cron][:hour] = '1'
override[:logstash][:index_cleaner][:cron][:log_file] = '/dev/null'

# kibana attributes
override[:kibana][:webserver] = 'apache'
override[:kibana][:apache][:enable_override_site] = true
