#
# Cookbook Name:: liferay
# Recipe:: postgresql
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

include_recipe "apt"

unless ENV['LANGUAGE'] == "en_US.UTF-8" && ENV['LANG'] == "en_US.UTF-8" && ENV['LC_ALL'] == "en_US.UTF-8"
  execute "setup-locale" do
    command "locale-gen en_US.UTF-8 && dpkg-reconfigure locales"
    action :run
  end

  template "/etc/default/locale" do
    source "locale.erb"
    action :create
  end

  ENV['LANGUAGE'] = ENV['LANG'] = ENV['LC_ALL'] = "en_US.UTF-8"
end

include_recipe "postgresql::server"
include_recipe "database::postgresql"

postgresql_connection_info = {:host => "127.0.0.1",
                              :port => node['postgresql']['config']['port'],
                              :username => 'postgres',
                              :password => node['postgresql']['password']['postgres']}


# create the liferay postgresql user but grant no privileges
postgresql_database_user node['liferay']['postgresql']['user'] do
  connection postgresql_connection_info
  password node['liferay']['postgresql']['user_password']
  action :create
end

# create databases
node['liferay']['postgresql']['database'].each do |db, name|
	postgresql_database name do
	  connection postgresql_connection_info
    template 'template0'
    encoding 'UTF8'
    tablespace 'DEFAULT'
    connection_limit '-1'
    owner node['liferay']['postgresql']['user']
    action :create
	end
end

