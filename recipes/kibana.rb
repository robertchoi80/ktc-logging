es_server_results = search(:node, node['logging']['elasticsearch_query'])
unless es_server_results.empty?
  node.set['kibana']['es_server'] = es_server_results[0]['ipaddress']
end

include_recipe "kibana"
