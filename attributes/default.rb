#
# Author::Adam Krone (<krone.adam@gmail.com>)
# Cookbook Name:: liferay
# Attributes:: default
#
# Copyright 2013, Thirdwave, LLC
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

default['liferay']['user'] = "liferay"

default['liferay']['group'] = "liferay"

default['liferay']['install_directory'] = "/opt"

default['liferay']['download_directory'] = "/usr/local/src/liferay"

default['liferay']['download_version'] = "liferay-portal-6.1.1-ce-ga2"

default['liferay']['download_filename'] = "liferay-portal-tomcat-6.1.1-ce-ga2-20120731132656558.zip"

default['liferay']['download_url'] = "http://downloads.sourceforge.net/project/lportal/Liferay%20Portal/6.1.1%20GA2/#{liferay['download_filename']}"

default['liferay']['extract_command'] = "sudo unzip #{liferay['download_directory']}/#{liferay['download_filename']} -d #{liferay['install_directory']}/"

default['liferay']['tomcat_version'] = "tomcat-7.0.27"

default['liferay']['start_command'] = "sudo #{liferay['install_directory']}/liferay/tomcat/bin/startup.sh"