#
# Cookbook Name:: liferay
# Recipe:: default
#
# Copyright 2013, Thirdwave, LLC
# Authors:
#  Adam Krone <adam.krone@thirdwavellc.com>
#  Henry Kastler <henry.kastler@thirdwavellc.com>
#  Orin Fink <orin.fink@thirdwavellc.com>
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

case node['platform_family']
when "debian"
  include_recipe "apt"
end

include_recipe "unzip"
include_recipe "imagemagick"
include_recipe "java"

user node['liferay']['user'] do
  comment "Liferay User"
  home "/home/#{node['liferay']['user']}"
  shell "/bin/bash"
  supports :manage_home=>true
end

remote_file "#{node['liferay']['download_directory']}/#{node['liferay']['download_filename']}" do
  owner node['liferay']['user']
  group node['liferay']['group']
  source node['liferay']['download_url']
  action :create_if_missing
end

bash "Extract Liferay" do
  cwd node['liferay']['download_directory']
  code "unzip #{node['liferay']['download_filename']} -d #{node['liferay']['install_directory']}"
  action :run
  not_if { File.directory? "#{node['liferay']['install_directory']}/#{node['liferay']['download_version']}" }
  notifies :run, "bash[Chown Liferay]", :immediately
end

bash "Chown Liferay" do
  cwd node['liferay']['install_directory']
  code "chown -R #{node['liferay']['user']}: #{node['liferay']['download_version']}"
  action :nothing
end

link "#{node['liferay']['install_directory']}/liferay" do
  owner node['liferay']['user']
  group node['liferay']['group']
  to "#{node['liferay']['install_directory']}/#{node['liferay']['download_version']}"
end

link "#{node['liferay']['install_directory']}/liferay/tomcat" do
  owner node['liferay']['user']
  group node['liferay']['group']
  to "#{node['liferay']['install_directory']}/#{node['liferay']['download_version']}/#{node['liferay']['tomcat_version']}"
end

Dir.glob("#{node['liferay']['install_directory']}/liferay/tomcat/bin/*.bat").each do |bat_file|
  file bat_file do
    action :delete
  end
end

template "#{node['liferay']['install_directory']}/liferay/tomcat/bin/setenv.sh" do
  source "setenv.sh.erb"
  mode 01755
  variables({
    :max_memory => node['liferay']['tomcat']['max_memory'],
    :min_memory => node['liferay']['tomcat']['min_memory'],
    :max_perm_size => node['liferay']['tomcat']['max_perm_size'],
    :additional_java_ops => node['liferay']['tomcat']['additional_java_ops']
  })
end

directory "#{node['liferay']['install_directory']}/liferay/tomcat/webapps/welcome-theme" do
  recursive true
  action :delete
end

service "liferay" do
  supports :restart => true
end

# Configure the Liferay Service and Log Rotations
template "/etc/init.d/liferay" do
  source "init.d.liferay.erb"
  mode 00755
  variables({
    :liferay_home => "#{node['liferay']['install_directory']}/liferay",
    :user => node['liferay']['user'],
    :group => node['liferay']['group']
  })
  notifies :enable, "service[liferay]", :delayed
  notifies :start, "service[liferay]", :delayed
end

template "/etc/logrotate.d/liferay" do
  source "logrotate.d.liferay.erb"
  mode 00755
  variables({
    :liferay_log_home => "#{node['liferay']['install_directory']}/liferay/tomcat/logs"
  })
end

directory "#{node['liferay']['install_directory']}/liferay/deploy" do
  owner node['liferay']['user']
  group node['liferay']['group']
  mode 01755
  action :create
  recursive true
end

template "#{node['liferay']['install_directory']}/liferay/tomcat/conf/server.xml" do
  source "server.xml.erb"
  mode 00755	
  owner node['liferay']['user']
  group node['liferay']['group']
  variables({
    :port => node['liferay']['tomcat']['server_xml']['port']
  })
end

directory "#{node['liferay']['install_directory']}/liferay/tomcat/conf/Catalina/localhost/" do
  owner node['liferay']['user']
  group node['liferay']['group']
  mode 01755
  action :create
end

template "#{node['liferay']['install_directory']}/liferay/tomcat/conf/Catalina/localhost/ROOT.xml" do
  source "ROOT.xml.erb"
  mode 00755	
  owner node['liferay']['user']
  group node['liferay']['group']
end

bash "Load EXT Environment" do
  cwd "/home/#{node['liferay']['user']}/"
	user node['liferay']['user']
  group node['liferay']['group']
  code <<-EOH
    ant deploy-properties -buildfile #{node['liferay']['ext_buildfile']}
    ant war -buildfile #{node['liferay']['ext_buildfile']}
    mkdir -p dist
    cp /vagrant/dist/*-ext-* dist/
    chown -R #{node['liferay']['user']}:#{node['liferay']['group']} dist
    cp dist/*-ext-* #{node['liferay']['install_directory']}/liferay/deploy/
  EOH
	action :run
	only_if { node['liferay']['load_ext'] == true }
end
