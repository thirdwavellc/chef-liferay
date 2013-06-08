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

postgresql_connection_info = {:host => "127.0.0.1",
                              :port => node['postgresql']['config']['port'],
                              :username => 'postgres',
                              :password => node['postgresql']['password']['postgres']}


    # create the liferay postgresql user but grant no privileges
    postgresql_database_user 'liferay_user' do
      connection postgresql_connection_info
      password 'l1f3r4y$'
      action :create
	end

    # create a postgresql database for use as default portal
    postgresql_database 'lportal' do
      connection postgresql_connection_info
      template 'template0'     
      encoding 'UTF8'
      tablespace 'DEFAULT'
      connection_limit '-1'
      owner 'liferay_user'
      action :create
    end
	
    # create a postgresql database for use as local dev
    postgresql_database 'liferay_dev' do
      connection postgresql_connection_info
      template 'template0'     
      encoding 'UTF8'
      tablespace 'DEFAULT'
      connection_limit '-1'
      owner 'liferay_user'
      action :create
    end

    # create an empty postgresql database for use as local staging
    postgresql_database 'liferay_stage' do
      connection postgresql_connection_info
      template 'template0'     
      encoding 'UTF8'
      tablespace 'DEFAULT'
      connection_limit '-1'
      owner 'liferay_user'
      action :create
    end

    # create an empty postgresql database for use as local production
    postgresql_database 'liferay_prod' do
      connection postgresql_connection_info
      template 'template0'     
      encoding 'UTF8'
      tablespace 'DEFAULT'
      connection_limit '-1'
      owner 'liferay_user'
      action :create
    end
