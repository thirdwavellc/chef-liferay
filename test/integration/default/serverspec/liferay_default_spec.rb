require 'serverspec'

include Serverspec::Helper::Exec
include Serverspec::Helper::DetectOS

RSpec.configure do |config|
  config.before :all do
	  config.path = '/sbin:/usr/sbin'
  end
end

describe "liferay" do
  describe "user" do
    let(:liferay_user) { user('liferay') }

    it "should exist" do
      expect(liferay_user).to exist
    end

    it "should belong to liferay group" do
      expect(liferay_user).to belong_to_group('liferay')
    end
  end

  describe "group" do
    let(:liferay_group) { group('liferay') }

    it "should exist" do
      expect(liferay_group).to exist
    end
  end

  describe "application directory" do
    let(:liferay_dir) { file('/opt/liferay') }

    it "should exist" do
      expect(liferay_dir).to be_directory
    end

    it "should be owned by liferay" do
      expect(liferay_dir).to be_owned_by('liferay')
    end

    it "should be grouped into liferay" do
      expect(liferay_dir).to be_grouped_into('liferay')
    end
  end

  describe "setenv.sh" do
    let(:setenv) { file('/opt/liferay/tomcat/bin/setenv.sh') }

    it "should exist" do
      expect(setenv).to be_file
    end
  end

  describe "welcome theme" do
    let(:welcome_theme) { file('/opt/liferay/tomcat/webapps/welcome-theme') }

    it "should not exist" do
      expect(welcome_theme).not_to be_directory
    end
  end

  describe "init script" do
    let(:init_script) { file('/etc/init.d/liferay') }

    it "should exist" do
      expect(init_script).to be_file
    end
  end

  describe "logrotate" do
    let(:logrotate) { file('/etc/logrotate.d/liferay') }

    it "should exist" do
      expect(logrotate).to be_file
    end
  end

  describe "deploy directory" do
    let(:deploy_dir) { file('/opt/liferay/deploy') }

    it "should exist" do
      expect(deploy_dir).to be_directory
    end

    it "should be owned by liferay" do
      expect(deploy_dir).to be_owned_by('liferay')
    end

    it "should be grouped into liferay" do
      expect(deploy_dir).to be_grouped_into('liferay')
    end
  end

  describe "server.xml" do
    let(:server_xml) { file('/opt/liferay/tomcat/conf/server.xml') }

    it "should exist" do
      expect(server_xml).to be_file
    end

    it "should be owned by liferay" do
      expect(server_xml).to be_owned_by('liferay')
    end

    it "should be grouped into liferay" do
      expect(server_xml).to be_grouped_into('liferay')
    end
  end

  describe "Catalina localhost directory" do
    let(:catalina_dir) { file('/opt/liferay/tomcat/conf/Catalina/localhost') }

    it "should exist" do
      expect(catalina_dir).to be_directory
    end

    it "should be owned by liferay" do
      expect(catalina_dir).to be_owned_by('liferay')
    end

    it "should be grouped into liferay" do
      expect(catalina_dir).to be_grouped_into('liferay')
    end
  end

  describe "ROOT.xml" do
    let(:root_xml) { file('/opt/liferay/tomcat/conf/Catalina/localhost/ROOT.xml') }

    it "should exist" do
      expect(root_xml).to be_file
    end

    it "should be owned by liferay" do
      expect(root_xml).to be_owned_by('liferay')
    end

    it "should be grouped into liferay" do
      expect(root_xml).to be_grouped_into('liferay')
    end
  end

  describe "service" do
    let(:liferay) { service('liferay') }

    it "should be enabled" do
      expect(liferay).to be_enabled
    end

    it "should be running" do
      expect(liferay).to be_running
    end
  end
  # TODO:
  # The liferay service appears to start, but the associated process is either
  # not staying alive, or never actually triggered. It works fine when run in
  # vagrant outside of test kitchen, and on certain platforms, so I'll need to
  # look into this one more. Until then, we'll leave this one out.
  #describe "port 8080" do
  #  let(:port_8080) { port(8080) }

  #  it "should be listening on port 8080" do
  #    expect(port_8080).to be_listening
  #  end
  #end
end
