# Liferay cookbook [![Build Status](https://secure.travis-ci.org/thirdwavellc/chef-liferay.png)](http://travis-ci.org/thirdwavellc/chef-liferay)

Configures the Liferay application environment. It is assumed that the application itself will
be deployed through some other means (Capistrano, separate cookbook, etc.).

# Platforms

Our Test Kitchen suite verifies the following platforms:

- Ubuntu 14.04
- Ubuntu 12.04
- CentOS 6.6
- CentOS 7.1

# LWRP

The primary way to consume this cookbook is through the LWRP it provides:

## liferay_app

**Attributes**

| Name       | Description                            | Type   | Required | Default                    |
| app_name   | Name of the application                | String | true     | N/A                        |
| user       | User that owns the Liferay process     | String | false    | 'liferay'                  |
| group      | Group that owns the Liferay process    | String | false    | 'liferay'                  |
| home_dir   | Home directory for Liferay app         | String | false    | '/opt/liferay'             |
| tomcat_dir | Tomcat directory in the Liferay bundle | String | false    | '/opt/liferay/tomcat'      |
| log_dir    | Tomcat log directory                   | String | false    | '/opt/liferay/tomcat/logs' |

# Attributes

| Attribute                       | Description                            | Default                    |
| `node['liferay']['app_name']`   | Name of the Liferay app                | 'liferay_app'              |
| `node['liferay']['user']`       | User tha owns the Liferay process      | 'liferay'                  |
| `node['liferay']['group']`      | Group that owns the Liferay process    | 'liferay'                  |
| `node['liferay']['home_dir']`   | Home directory for the Liferay app     | '/opt/liferay'             |
| `node['liferay']['tomcat_dir']` | Tomcat directory in the Liferay bundle | '/opt/liferay/tomcat'      |
| `node['liferay']['log_dir']`    | Tomcat log directory                   | '/opt/liferay/tomcat/logs' |

# Recipes

* **default** - Uses the liferay_app LWRP and node attributes to configure a Liferay environment

# License and Authors

* Author:: Adam Krone <adam.krone@thirdwavellc.com>
* Author:: Henry Kastler <henry.kastler@thirdwavellc.com>
* Author:: Orin Fink <orin.fink@thirdwavellc.com>

* Copyright:: 2015, Thirdwave, LLC

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
