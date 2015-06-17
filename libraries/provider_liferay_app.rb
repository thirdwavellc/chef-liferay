#
# Cookbook Name:: liferay
# Provider:: liferay_app
#
#     Copyright 2014 Adam Krone <adam.krone@thirdwavellc.com>
#     Copyright 2014 Thirdwave, LLC
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

require 'chef/provider/lwrp_base'

class Chef
  class Provider
    class LiferayApp < Chef::Provider::LWRPBase
      include Chef::DSL::IncludeRecipe
      use_inline_resources if defined?(use_inline_resources)

      def whyrun_supported?
        true
      end

      action :create do
        case node['platform_family']
        when 'debian'
          include_recipe 'apt'
        when 'rhel'
          include_recipe 'yum'
        end

        include_recipe 'imagemagick'
        include_recipe 'java'

        user new_resource.user do
          comment 'Liferay User'
          action :create
        end

        service 'liferay' do
          supports restart: true
        end

        template '/etc/init.d/liferay' do
          source 'liferay.init.erb'
          mode 00755
          variables(tomcat_dir: new_resource.tomcat_dir,
                    user: new_resource.user,
                    group: new_resource.group)
          notifies :enable, 'service[liferay]', :delayed
        end

        template '/etc/logrotate.d/liferay' do
          source 'logrotate.d.liferay.erb'
          mode 00755
          variables(liferay_log_home: new_resource.log_dir)
        end

        directory new_resource.home_dir do
          owner new_resource.user
          group new_resource.group
          action :create
        end
      end
    end
  end
end
