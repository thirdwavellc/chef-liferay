#
# Cookbook Name:: liferay
# Attributes:: default
#
# Copyright 2015, Thirdwave, LLC
# Authors:
#     Adam Krone <adam.krone@thirdwavellc.com>
#     Henry Kastler <henry.kastler@thirdwavellc.com>
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

default['liferay']['app_name'] = 'liferay_app'
default['liferay']['user'] = 'liferay'
default['liferay']['group'] = 'liferay'
default['liferay']['home_dir'] = '/opt/liferay'
default['liferay']['tomcat_dir'] = '/opt/liferay/tomcat'
default['liferay']['log_dir'] = '/opt/liferay/tomcat/logs'
