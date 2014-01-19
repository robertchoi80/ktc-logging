chef_gem "chef-rewind"
require 'chef/rewind'

es_server_results = search(:node, node['logging']['elasticsearch_query'])
unless es_server_results.empty?
  node.set['kibana']['es_server'] = es_server_results[0]['ipaddress']
end

include_recipe "kibana"

rewind :template => "#{node['kibana']['web_dir']}/config.js" do
  source "config-new.js.erb"
  cookbook "ktc-logging"
  variables(:es_host => node['kibana']['es_server'],
    :es_port => node['kibana']['es_port']
  )
end
