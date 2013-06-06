#
# Cookbook Name:: liferay
# Recipe:: default
#
# Copyright 2013, Thirdwave, LLC
# Authors:
# 		Adam Krone <adam.krone@thirdwavellc.com>
#		Henry Kastler <henry.kastler@thirdwavellc.com>
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
	source "setenv.sh.erb"
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

directory "#{node['liferay']['install_directory']}/liferay/deploy" do
	action :create
end

#link "#{node['liferay']['install_directory']}/liferay/deploy" do
#	to "/vagrant/dist"
#end

file "#{node['liferay']['install_directory']}/liferay/tomcat/conf/server.xml" do
	action :delete
end

template "#{node['liferay']['install_directory']}/liferay/tomcat/conf/server.xml" do
	source "server.xml.erb"
	mode 00755	
	owner "liferay"
	group "liferay"
	variables({
		:port => node[:liferay][:tomcat][:server_xml][:port]		
	})
end

directory "#{node['liferay']['install_directory']}/liferay/tomcat/conf/Catalina/localhost/" do
	action :create
end

template "#{node['liferay']['install_directory']}/liferay/tomcat/conf/Catalina/localhost/ROOT.xml" do
	source "ROOT.xml.erb"
	mode 00755	
	owner "liferay"
	group "liferay"
	variables({
		:dsn => node[:liferay][:tomcat][:root_xml][:dsn],
		:username => node[:liferay][:tomcat][:root_xml][:username],
		:password => node[:liferay][:tomcat][:root_xml][:password],
		:driver => node[:liferay][:tomcat][:root_xml][:driver],
		:jdbc_url => node[:liferay][:tomcat][:root_xml][:jdbc_url]
	})
end

execute "copy over patching tool" do
	command "sudo cp /vagrant/downloads/patching-tool/patching-tool-9.zip #{node['liferay']['install_directory']}/liferay/patching-tool.zip"
end

execute "extract patching tool" do
	command "sudo rm -rf #{node['liferay']['install_directory']}/liferay/patching-tool"
	command "sudo unzip #{node['liferay']['install_directory']}/liferay/patching-tool.zip"
	command "sudo rm #{node['liferay']['install_directory']}/liferay/patching-tool.zip"
end

execute "copy over patches" do
	command "sudo cp /vagrant/downloads/patches/* #{node['liferay']['install_directory']}/liferay/patching-tool/patches/."
end

#create this file needed for the patch install
template "#{node['liferay']['install_directory']}/liferay/patching-tool/default.properties" do
	source "patching_tool.default.properties.erb"
	mode 00755	
	owner "liferay"
	group "liferay"	
end

execute "patching tool install" do
	command "sudo sh #{node['liferay']['install_directory']}/liferay/patching-tool/patching-tool.sh install"
end

execute "install ecj" do
	command "sudo cp /vagrant/lib/ecj.jar /usr/share/ant/lib/."	
end

execute "load ext" do
	command "sudo ant direct-deploy -buildfile /vagrant/ext/atk-ext/build.xml"	
end

bash "Start Liferay" do
	code node['liferay']['start_command']
	action :run
end