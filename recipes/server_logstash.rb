#
# CookBook:: ktc-logging
# Recipe:: server_logstash
#

# include recipes from our run_list attribute
#
node[:logging][:recipes_server_logstash].each do |recipe|
  include_recipe recipe
end
