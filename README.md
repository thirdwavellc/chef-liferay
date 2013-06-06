# Liferay cookbook

# Requirements

**cookbooks**

* unzip
* imagemagick
* java
* mysql-connector (if using Liferay CE)
* database
* mysql/postgresql

# Platforms

Currently only tested on Ubuntu 12.04, but should play nice within the Debian family.

# Usage

The Vagrantfile included in this repo should give you an idea of what a typical Ubuntu 12.04 configuration will look like for Liferay CE, MySQL, and PostgreSQL servers. For an EE configuration, consult the attributes below.

# Attributes

**User**

* `node['liferay']['user']` - OS user for Liferay
* `node['liferay']['group']` - OS group for Liferay

**Install**

* `node['liferay']['install_directory']` - Location to put the Liferay directory


**Liferay Download**

* `node['liferay']['download_directory']` - Location to store files before installation
* `node['liferay']['download_version']` - Version of Liferay to download (also the name of the directory creating after extracting)
* `node['liferay']['download_filename']` - Filename of Liferay zip
* `node['liferay']['download_url']` - Location of where to download Liferay
* `node['liferay']['tomcat_version']` - Version of Tomcat

**Commands**

* `node['liferay']['extract_command']` - Command to extract Liferay download
* `node['liferay']['start_command']` - Command to start the Tomcat server
* `node['liferay']['stop_command']` - Command to stop the Tomcat server
* `node['liferay']['install_marketplace_plugins_command']` - Command to install any plugins
* `node['liferay']['move_patch_command']` - Command to move patches for deployment
* `node['liferay']['install_patch_command']` - Command to install patches

**Enterprise Edition**

* `node['liferay']['ee']['license_filename']` - Filename for developer license
* `node['liferay']['ee']['license_url']` - Location to download developer license file

**Tomcat**

* `node['liferay']['tomcat']['server_xml']['port']` - Port Tomcat should run on
* `node['liferay']['tomcat']['root_xml']['dsn']` - DSN to create
* `node['liferay']['tomcat']['root_xml']['username']` - Username to create DSN
* `node['liferay']['tomcat']['root_xml']['password']` - Password to create DSN
* `node['liferay']['tomcat']['root_xml']['driver']` - Driver to use for DSN
* `node['liferay']['tomcat']['root_xml']['jdbc_url']` - Location to access database

# Recipes

* **default** - Installs typical CE configuration
* **enterprise** - Installs additional compoments for EE
* **mysql** - Creates Liferay MySQL database
* **postgresql** - Creates Liferay PostgreSQL database 
* **patches** - Installs patches for Liferay
* **plugins** - Installs marketplace plugins for Liferay
* **load_sdk_dist** - Loads components from sdk dist
* **aliases** - Includes a collection of useful bash aliases when developing

# License and Authors

* Author:: Adam Krone <adam.krone@thirdwavellc.com>
* Author:: Henry Kastler <henry.kastler@thirdwavellc.com>

* Copyright:: 2013, Thirdwave, LLC

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
