require 'spec_helper'

describe 'liferay::default' do
  let (:chef_run) do
    runner = ChefSpec::ChefRunner.new
    runner.converge 'liferay::default'
  end

  it 'should include apt::default' do
    expect(chef_run).to include_recipe 'apt::default'
  end

  it 'should include unzip::default' do
    expect(chef_run).to include_recipe 'unzip::default'
  end

  it 'should include imagemagick::default' do
    expect(chef_run).to include_recipe 'imagemagick::default'
  end

  it 'should include java::default' do
    expect(chef_run).to include_recipe 'java::default'
  end

  # create_remote_file_if_missing appears to be broken at the moment
  # 
  # it 'should download the liferay zip' do
  #   expect(chef_run).to create_remote_file_if_missing '/home/liferay/liferay-portal-tomcat-6.1.1-ce-ga2-20120731132656558.zip'
  # end

  it 'should extract liferay' do
    expect(chef_run).to execute_bash_script 'Extract Liferay'
  end

  it 'should move liferay' do
    expect(chef_run).to execute_bash_script 'Move Liferay'
  end

  it 'should create liferay-versioned directory' do
    expect(chef_run).to create_link '/opt/liferay'
    expect(chef_run.link('/opt/liferay')).to link_to "/opt/liferay-portal-6.1.1-ce-ga2"
  end

  it 'should create tomcat-versioned directory' do
    expect(chef_run).to create_link '/opt/liferay/tomcat'
    expect(chef_run.link('/opt/liferay/tomcat')).to link_to '/opt/liferay/tomcat-7.0.27'
  end

  # delete bat files

  it 'should create setenv.sh from template' do
    expect(chef_run).to create_file '/opt/liferay/tomcat/bin/setenv.sh'
  end

  it 'should delete the welcome theme' do
    expect(chef_run).to delete_directory '/opt/liferay/tomcat/webapps/welcome-theme'
  end

  it 'should create liferay init script' do
    expect(chef_run).to create_file '/etc/init.d/liferay'
  end

  it 'should create the liferay logrote' do
    expect(chef_run).to create_file '/etc/logrotate.d/liferay'
  end

  it 'should create the liferay deploy directory' do
    expect(chef_run).to create_directory '/opt/liferay/deploy'
  end

  it 'should create the server config' do
    expect(chef_run).to create_file '/opt/liferay/tomcat/conf/server.xml'
  end

  it 'should create the catalina localhost config directory' do
    expect(chef_run).to create_directory '/opt/liferay/tomcat/conf/Catalina/localhost/'
  end

  it 'should create the root.xml config' do
    expect(chef_run).to create_file '/opt/liferay/tomcat/conf/Catalina/localhost/ROOT.xml'
  end

  describe 'when load_ext is set' do
    let (:chef_run) do
      runner = ChefSpec::ChefRunner.new
      runner.node.set['liferay']['load_ext'] = true
      runner.converge 'liferay::default'
    end

    it 'should load the EXT environment' do
      expect(chef_run).to execute_bash_script 'Load EXT Environment'
    end
  end

  # it 'should start liferay' do
  #   expect(chef_run).to start_service 'liferay'
  # end
end
