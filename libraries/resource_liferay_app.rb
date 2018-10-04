#
# Cookbook Name:: liferay
# Resource:: liferay_app
#
# Copyright 2015 Adam Krone <adam.krone@thirdwavellc.com>
# Copyright 2015 Thirdwave, LLC
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

require 'chef/resource/lwrp_base'

class Chef
  class Resource
    class LiferayApp < Chef::Resource::LWRPBase
      self.resource_name = :liferay_app
      actions :create
      default_action :create

      attribute :app_name, kind_of: String, name_attribute: true
      attribute :user, kind_of: String, default: 'liferay'
      attribute :group, kind_of: String, default: 'liferay'
      attribute :deploy_dir, kind_of: String, default: '/opt/liferay'
      attribute :home_dir, kind_of: String, default: '/opt/liferay'
      attribute :tomcat_dir, kind_of: String, default: '/opt/liferay/tomcat'
      attribute :log_dir, kind_of: String, default: '/opt/liferay/tomcat/logs'
      attribute :timeout_start, kind_of: Integer, default: 600
      attribute :timeout_stop, kind_of: Integer, default: 200
    end
  end
end
