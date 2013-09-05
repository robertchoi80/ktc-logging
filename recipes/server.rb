#
# CookBook:: ktc-logging
# Recipe:: server
#

# include recipes from our run_list attribute
#
node[:logging][:server_recipes].each do |recipe|
  include_recipe recipe
end
