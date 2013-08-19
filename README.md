# Liferay cookbook [![Build Status](https://secure.travis-ci.org/thirdwavellc/chef-liferay.png)](http://travis-ci.org/thirdwavellc/chef-liferay)

# Requirements

**cookbooks**

* unzip
* imagemagick
* java
* mysql-connector (if using Liferay CE)
* database
* mysql/postgresql

# Platforms

Tested on Ubuntu 12.04, but should play nice within the Debian family. Initial support for RHEL distros has been added, but is not as thoroughly tested at the moment.

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

**Enterprise Edition**

* `node['liferay']['ee']['license_filename']` - Filename for developer license
* `node['liferay']['ee']['license_url']` - Location to download developer license file

**Tomcat**

*Memory Settings in setenv.sh*
* `node['liferay']['tomcat']['max_memory']` - Maximum size of the Java heap (-Xmx)
* `node['liferay']['tomcat']['min_memory']` - Initial and minimum size of Java heap (-Xms)
* `node['liferay']['tomcat']['max_perm_size']` -  Maximum size for the permanent generation space (-XX:MaxPermSize)

*Port settings in server.xml*
* `node['liferay']['tomcat']['server_xml']['port']` - The port Tomcat should run on

*JNDI Resource in {tomcat-home}/conf/Catalina/localhost/ROOT.xml*
* `node['liferay']['tomcat']['root_xml']['jndi_resource']` - Hash of JNDI Resource settings to use in ROOT.xml server context

for example
```json
  :jndi_resource=>{
    :name=>"jdbc/my_liferay",
    :auth=>"Container",
    :type=>"javax.sql.DataSource",
    :factory=>"org.apache.tomcat.jdbc.pool.DataSourceFactory",
    :username=>"liferay_user",
    :password=>"mypassword",
    :driverClassName=>"com.mysql.jdbc.Driver",
    :url=>"jdbc:mysql://db.company.com:3306/lportal"
  }
```

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
* Author:: Orin Fink <orin.fink@thirdwavellc.com>

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
