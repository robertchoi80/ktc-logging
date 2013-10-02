#
# CookBook:: ktc-logging
# Recipe:: server_es
#

# include recipes from our run_list attribute
#
node[:logging][:recipes_server_es].each do |recipe|
  include_recipe recipe
end
