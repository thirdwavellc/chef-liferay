#
# Cookbook Name:: liferay
# Recipe:: patches
#
# Copyright 2013, Thirdwave, LLC
# Authors:
# 		Adam Krone <adam.krone@thirdwavellc.com>
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

bash "Stop Liferay" do
	code node['liferay']['stop_command']
	action :run
end

directory "#{node['liferay']['install_directory']}/liferay/patching-tool/patches" do
	recursive true
	action :create
end

bash "Move patches" do
	user "root"
	code node['liferay']['move_patch_command']
	action :run
end

bash "Install patches" do
	user "root"
	cwd "#{node['liferay']['install_directory']}/liferay/patching-tool"
	code node['liferay']['install_patch_command']
	action :run
end

bash "Start Liferay" do
	code node['liferay']['start_command']
	action :run
end