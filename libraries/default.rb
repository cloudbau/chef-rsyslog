def get_rsyslog_server_ip
  if node[:rsyslog][:server_ip]
    node[:rsyslog][:server_ip]
  else
    search(:node, "recipes:rsyslog\\:\\:server AND chef_environment:#{node.chef_environment}").map {|n| n[:rsyslog][:server_ip]}.first
  end
end

def get_logstash_server_ip
    search(:node, "roles:logstash-server AND chef_environment:#{node.chef_environment}").first.ipaddress
end