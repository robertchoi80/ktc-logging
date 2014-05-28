#
# CookBook:: ktc-logging
# Recipe:: server_es
#

# include recipes from our run_list attribute
#
node[:logging][:recipes_server_es].each do |recipe|
  include_recipe recipe
end

chef_gem 'chef-rewind'
require 'chef/rewind'

rewind template: 'logging.yml' do
  source "es_logging.yml.erb"
  cookbook_name "ktc-logging"
end

# process monitoring and sensu-check config
processes = node[:logging][:es_processes]

processes.each do |process|
  sensu_check "check_process_#{process[:name]}" do
    command "check-procs.rb -c 10 -w 10 -C 1 -W 1 -p #{process[:name]}"
    handlers ['default']
    standalone true
    interval 30
  end
end

ktc_collectd_processes 'es-processes' do
  input processes
end
