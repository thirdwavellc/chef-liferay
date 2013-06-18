#
# Cookbook Name:: liferay
# Recipe:: load_marketplace_lpkgs
#
# Copyright 2013, Thirdwave, LLC
# Authors:
# 		Henry Kastler <henry.kastler@thirdwavellc.com>
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

bash "load-marketplace-lpkgs" do
  cwd "/home/#{node['liferay']['user']}/"
  user node['liferay']['user']
  group node['liferay']['group']
  code <<-EOH
    mkdir -p dist/marketplace
    cp /vagrant/downloads/marketplace/* dist/marketplace/
    chown -R #{node['liferay']['user']}:#{node['liferay']['group']} dist/marektplace
    cp dist/marketplace/* #{node['liferay']['install_directory']}/liferay/deploy/
    EOH
  action :run
end