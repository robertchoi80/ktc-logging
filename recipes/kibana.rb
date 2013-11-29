es_server_results = search(:node, "recipes:#{node['logging']['elasticsearch_recipe']} AND chef_environment:#{node.chef_environment}")
unless es_server_results.empty?
  node.set['kibana']['es_server'] = es_server_results[0]['ipaddress']
end

include_recipe "kibana"
