#
# Cookbook Name:: rsyslog
# Recipe:: client
#
# Copyright 2009-2013, Opscode, Inc.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

include_recipe "rsyslog"
logstash_server = nil
rsyslog_server = get_rsyslog_server_ip
if rsyslog_server.nil?
  Chef::Application.fatal!("The rsyslog::client recipe was unable to determine the remote syslog server. Checked both the server_ip attribute and search()")
end

logstash_server = get_logstash_server_ip
if logstash_server.nil? || logstash_server.empty?
  Chef::Application.fatal!("No Logstash Server found!")
end

template "/etc/rsyslog.d/49-remote.conf" do
  only_if { node['rsyslog']['remote_logs'] && !rsyslog_server.nil? }
  source "49-remote.conf.erb"
  backup false
  variables(
  :server => rsyslog_server,
  :protocol => node['rsyslog']['protocol'],
  :logstash => logstash_server
  )
  mode 0644
  notifies :restart, "service[#{node['rsyslog']['service_name']}]"
end

file "/etc/rsyslog.d/server.conf" do
  action :delete
  notifies :reload, "service[#{node['rsyslog']['service_name']}]"
end
