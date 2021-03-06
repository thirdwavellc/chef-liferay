#
# Cookbook Name:: liferay
# Recipe:: default
#
# Copyright 2015, Thirdwave, LLC
# Authors:
#    Adam Krone <adam.krone@thirdwavellc.com>
#    Henry Kastler <henry.kastler@thirdwavellc.com>
#    Orin Fink <orin.fink@thirdwavellc.com>
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

liferay_app node['liferay']['app_name'] do
  user node['liferay']['user']
  group node['liferay']['group']
  home_dir node['liferay']['home_dir']
  tomcat_dir node['liferay']['tomcat_dir']
  log_dir node['liferay']['log_dir']
  action :create
end
