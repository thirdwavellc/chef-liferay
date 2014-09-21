require 'chefspec'

describe 'liferay::enterprise' do
  let(:liferay_ee_zip_filename) { 'liferay-ee.zip' }
  let(:liferay_ee_zip_url) { 'http://www.example.com/liferay-ee.zip' }
  let(:liferay_ee_zip_location) { "#{Chef::Config[:file_cache_path]}/#{liferay_ee_zip_filename}" }
  let(:liferay_ee_license_filename) { 'license' }
  let(:liferay_ee_license_url) { "http://www.example.com/#{liferay_ee_license_filename}" }
  let(:liferay_ee_license_location) { '/opt/liferay/deploy/license'}
  let (:chef_run) do
    ChefSpec::Runner.new(platform: 'ubuntu', version: '12.04') do |node|
      node.set['liferay']['download_filename'] = liferay_ee_zip_filename
      node.set['liferay']['download_url'] = liferay_ee_zip_url
      node.set['liferay']['ee']['license_filename'] = liferay_ee_license_filename
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
    expect(chef_run).to create_remote_file_if_missing liferay_ee_zip_location
  end

  it 'should download the liferay license zip' do
    expect(chef_run).to create_remote_file_if_missing liferay_ee_license_location
  end
end
