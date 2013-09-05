#
# CookBook:: ktc-logging
# Recipe:: client
#

# include recipes from our run_list attribute
#
node[:logging][:client_recipes].each do |recipe|
  include_recipe recipe
end
