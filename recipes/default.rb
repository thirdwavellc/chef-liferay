#
# Cookbook Name:: liferay
# Recipe:: default
#
# Copyright 2013, Thirdwave, LLC
# Authors:
# 		Adam Krone <krone.adam@gmail.com>
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

directory "/usr/local/src/liferay" do
	action :create
end

remote_file "/usr/local/src/liferay/liferay-portal-tomcat-6.1.1-ce-ga2-20120731132656558.zip" do
	source "http://downloads.sourceforge.net/project/lportal/Liferay%20Portal/6.1.1%20GA2/liferay-portal-tomcat-6.1.1-ce-ga2-20120731132656558.zip"
	mode 00755
	action :create_if_missing
	notifies :run, "bash[unzip liferay]", :immediately
end

bash "unzip liferay" do
	code <<-EOH
	sudo unzip /usr/local/src/liferay/liferay-portal-tomcat-6.1.1-ce-ga2-20120731132656558.zip -d /opt/
	EOH
	action :nothing
end

link "/opt/liferay" do
	to "/opt/liferay-portal-6.1.1-ce-ga2"
end

link "/opt/liferay/tomcat" do
	to "/opt/liferay/tomcat-7.0.27"
end

file "/opt/liferay/tomcat/bin/*.bat" do
	action :delete
end

bash "Optimize memory setting" do
	code <<-EOH
	sudo sed -i "1c JAVA_OPTS=\\"\\$JAVA_OPTS -Dfile.encoding=UTF8 -Dorg.apache.catalina.loader.WebappClassLoader.ENABLE_CLEAR_REFERENCES=false -Duser.timezone=GMT -Dcompany-id-properties=true -Xms1024m -Xmx1024m -XX:MaxPermSize=512m\\"" /opt/liferay/tomcat/bin/setenv.sh
	EOH
	action :run
end

directory "/opt/liferay/tomcat/webapps/welcome-theme" do
	recursive true
	action :delete
end

user "liferay" do
	comment "Liferay User"
end

execute "change /opt/liferay ownership" do
	command "sudo chown -R liferay:liferay /opt/liferay"
end

template "/etc/init.d/liferay" do
	source "init.d.liferay.erb"
	mode 00755
end

link "/etc/rc1.d/K99liferay" do
	to "/etc/init.d/liferay"
end

link "/etc/rc2.d/S99liferay" do
	to "/etc/init.d/S99liferay"
end

template "/etc/logrotate.d/liferay" do
	source "logrotate.d.liferay.erb"
	mode 00755
end

bash "Start Liferay" do
	code <<-EOH
	sudo /opt/liferay/tomcat/bin/startup.sh
	EOH
	action :run
end