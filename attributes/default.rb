#
# Cookbook Name:: liferay
# Attributes:: default
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

# User
default['liferay']['user'] = "liferay"
default['liferay']['group'] = "liferay"

# Install
default['liferay']['install_directory'] = "/opt"

# Liferay Download
default['liferay']['download_directory'] = Chef::Config[:file_cache_path]
default['liferay']['download_version'] = "liferay-portal-6.1.1-ce-ga2"
default['liferay']['download_filename'] = "liferay-portal-tomcat-6.1.1-ce-ga2-20120731132656558.zip"
default['liferay']['download_url'] = "http://downloads.sourceforge.net/project/lportal/Liferay%20Portal/6.1.1%20GA2/#{liferay['download_filename']}"
default['liferay']['tomcat_version'] = "tomcat-7.0.27"

# Commands
default['liferay']['extract_command'] = "unzip #{liferay['download_directory']}/#{liferay['download_filename']} -d #{liferay['install_directory']}/"
default['liferay']['start_command'] = "#{liferay['install_directory']}/liferay/tomcat/bin/startup.sh"
default['liferay']['stop_command'] = "#{liferay['install_directory']}/liferay/tomcat/bin/shutdown.sh"
default['liferay']['install_marketplace_plugins_command'] = "cp /vagrant/downloads/marketplace/* #{liferay['install_directory']}/liferay/deploy/"
default['liferay']['load_ext_command'] = "ant direct-deploy -buildfile /vagrant/ext/your-ext/build.xml"
default['liferay']['copy_ecj'] = "cp /vagrant/lib/ecj.jar /usr/share/ant/lib/ecj.jar"

# EE
default['liferay']['ee']['license_filename'] = "your-license-here"
default['liferay']['ee']['license_url'] = "your-license-here"
default['liferay']['ee']['patching_tool_zip'] = ""

# Tomcat
default['liferay']['tomcat']['server_xml']['port'] = "8080"
default['liferay']['tomcat']['root_xml']['jndi_resource']['name'] = "jdbc/lportal"
default['liferay']['tomcat']['root_xml']['jndi_resource']['auth'] = "Container"
default['liferay']['tomcat']['root_xml']['jndi_resource']['type'] = "javax.sql.DataSource"
default['liferay']['tomcat']['root_xml']['jndi_resource']['username'] = "liferay_user"
default['liferay']['tomcat']['root_xml']['jndi_resource']['password'] = "l1f3r4y$"
default['liferay']['tomcat']['root_xml']['jndi_resource']['driverClassName'] = "org.postgresql.Driver"
default['liferay']['tomcat']['root_xml']['jndi_resource']['url'] = "jdbc:postgresql://localhost:5432/lportal"
default['liferay']['tomcat']['max_memory'] = "1024m"
default['liferay']['tomcat']['min_memory'] = "1024m"
default['liferay']['tomcat']['max_perm_size'] = "384m"
default['liferay']['tomcat']['additional_java_ops'] = ""
default['liferay']['tomcat']['jndi_resource']['name']
  
# PostgreSQL
default['liferay']['postgresql']['user'] = "liferay_user"
default['liferay']['postgresql']['user_password'] = "l1f3r4y$"
default['liferay']['postgresql']['database']['default'] = "lportal"
default['liferay']['postgresql']['database']['dev'] = "liferay_dev"
default['liferay']['postgresql']['database']['staging'] = "liferay_stage"
default['liferay']['postgresql']['database']['production'] = "liferay_prod"
  
# MySQL
default['liferay']['mysql']['user'] = "liferay_user"
default['liferay']['mysql']['user_password'] = "l1f3r4y$"
default['liferay']['mysql']['database']['default'] = "lportal"
default['liferay']['mysql']['database']['dev'] = "liferay_dev"
default['liferay']['mysql']['database']['staging'] = "liferay_stage"
default['liferay']['mysql']['database']['production'] = "liferay_prod"

# EXT
default['liferay']['load_ext'] = false
