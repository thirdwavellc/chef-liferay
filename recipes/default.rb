#
# Cookbook Name:: liferay
# Recipe:: default
#
# Copyright 2013, Thirdwave, LLC
# Authors:
# 		Adam Krone <krone.adam@gmail.com>
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

directory node['liferay']['download_directory'] do
	action :create
end

remote_file "#{node['liferay']['download_directory']}/#{node['liferay']['download_filename']}" do
	source node['liferay']['download_url']
	mode 00755
	action :create_if_missing
	notifies :run, "bash[Extract Liferay]", :immediately
end

bash "Extract Liferay" do
	code node['liferay']['extract_command']
	action :nothing
end

link "#{node['liferay']['install_directory']}/liferay" do
	to "#{node['liferay']['install_directory']}/#{node['liferay']['download_version']}"
end

link "#{node['liferay']['install_directory']}/liferay/tomcat" do
	to "/opt/liferay/#{node['liferay']['tomcat_version']}"
end

file "#{node['liferay']['install_directory']}/liferay/tomcat/bin/*.bat" do
	action :delete
end

template "#{node['liferay']['install_directory']}/liferay/tomcat/bin/setenv.sh" do
	source "setenv.sh"
	mode 00755
end

directory "#{node['liferay']['install_directory']}/liferay/tomcat/webapps/welcome-theme" do
	recursive true
	action :delete
end

user node['liferay']['user'] do
	comment "Liferay User"
end

execute "Change #{node['liferay']['install_directory']}/liferay ownership" do
	command "sudo chown -R #{node['liferay']['user']}:#{node['liferay']['group']} #{node['liferay']['install_directory']}/liferay"
end

template "/etc/init.d/liferay" do
	source "init.d.liferay.erb"
	mode 00755
end

link "/etc/rc1.d/K99liferay" do
	to "/etc/init.d/liferay"
end

link "/etc/rc2.d/S99liferay" do
	to "/etc/init.d/S99liferay"
end

template "/etc/logrotate.d/liferay" do
	source "logrotate.d.liferay.erb"
	mode 00755
end

bash "Start Liferay" do
	code node['liferay']['start_command']
	action :run
end