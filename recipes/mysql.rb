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
mysql_database_user node['liferay']['postgresql']['user'] do
  connection mysql_connection_info
  password node['liferay']['postgresql']['user_password']
  action :create
end

                           
mysql_database "lportal" do
	connection mysql_connection_info
  owner node['liferay']['postgresql']['user']
	action :create
end

# grant select,update,insert privileges to all tables in lportal db from all hosts
mysql_database_user node['liferay']['postgresql']['user'] do
  connection mysql_connection_info
  password node['liferay']['postgresql']['user_password']
  database_name 'lportal'
  host '%'
  privileges [:all]
  action :grant
end