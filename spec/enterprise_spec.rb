require 'chefspec'

describe 'liferay::enterprise' do
  let(:liferay_ee_zip_url) { 'http://www.example.com/liferay-ee.zip' }
  let(:liferay_ee_license_url) { 'http://www.example.com/license' }
  let (:chef_run) do
    runner = ChefSpec::Runner.new(platform: 'ubuntu', version: '12.04') do |node|
      node.set['liferay']['download_url'] = liferay_ee_zip_url
      node.set['liferay']['ee']['license_url'] = liferay_ee_license_url
    end.converge(described_recipe)
  end

  before do
    stub_command("update-alternatives --display java | grep '/usr/lib/jvm/java-6-openjdk-amd64/jre/bin/java - priority 1061'").and_return(true)
  end

  it 'should include the liferay::default' do
    expect(chef_run).to include_recipe 'liferay::default'
  end

  it 'should download the liferay ee zip' do
    pending("node attributes don't appear to be overriding correctly")
    expect(chef_run).to create_remote_file_if_missing liferay_ee_zip_url
  end

  it 'should download the liferay license zip' do
    pending("node attributes don't appear to be overriding correctly")
    expect(chef_run).to create_remote_file_if_missing liferay_ee_license_url
  end
end
