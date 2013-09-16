#
# Cookbook Name:: liferay
# Recipe:: patches
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

if not node['liferay']['ee']['patching_tool_zip'] == ""
	directory "#{node['liferay']['install_directory']}/liferay/patching-tool" do
		action :delete 
		recursive true
	end

	execute "copy over patching tool #{node['liferay']['ee']['patching_tool_zip']}" do
		command "sudo -u #{node['liferay']['user']} cp /vagrant/downloads/patching-tool/#{node['liferay']['ee']['patching_tool_zip']} #{node['liferay']['install_directory']}/liferay/#{node['liferay']['ee']['patching_tool_zip']}"
	end	

	execute "extract #{node['liferay']['ee']['patching_tool_zip']}" do
		cwd "#{node['liferay']['install_directory']}/liferay/"
		command "sudo -u #{node['liferay']['user']} unzip -o #{node['liferay']['ee']['patching_tool_zip']}"
	end
end

execute "copy over patches" do
	command "sudo -u #{node['liferay']['user']} cp /vagrant/downloads/patches/* #{node['liferay']['install_directory']}/liferay/patching-tool/patches/"
end

#create this file needed for the patch install
template "#{node['liferay']['install_directory']}/liferay/patching-tool/default.properties" do
	source "patching_tool.default.properties.erb"
	mode 00755	
	owner node['liferay']['user']
	group node['liferay']['group']	
end

execute "patching tool install" do
	command "sudo -u #{node['liferay']['user']} sh #{node['liferay']['install_directory']}/liferay/patching-tool/patching-tool.sh install"
end