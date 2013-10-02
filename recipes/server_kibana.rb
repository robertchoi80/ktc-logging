#
# CookBook:: ktc-logging
# Recipe:: server_kibana
#

# include recipes from our run_list attribute
#
node[:logging][:recipes_server_kibana].each do |recipe|
  include_recipe recipe
end
