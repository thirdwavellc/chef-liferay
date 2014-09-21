#
# Cookbook Name:: liferay
# Recipe:: mysql
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

mysql_connection_info = {:host => "localhost",
                         :username => 'root',
                         :password => node['mysql']['server_root_password']}

# create the liferay mysql user but grant no privileges
mysql_database_user node['liferay']['mysql']['user'] do
  connection mysql_connection_info
  password node['liferay']['mysql']['user_password']
  action :create
end

# create databases
node['liferay']['mysql']['database'].each do |db, name|
  mysql_database name do
  	connection mysql_connection_info
    owner node['liferay']['mysql']['user']
	  action :create
  end

  # grant select,update,insert privileges to all tables in default db from all hosts
  mysql_database_user node['liferay']['mysql']['user'] do
    connection mysql_connection_info
    password node['liferay']['mysql']['user_password']
    database_name name 
    host '%'
    privileges [:all]
    action :grant
  end
end				
