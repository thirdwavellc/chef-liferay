require 'chefspec'

describe 'liferay::load_sdk_dist' do
  let (:chef_run) { ChefSpec::Runner.new(platform: 'ubuntu', version: '12.04').converge 'liferay::load_sdk_dist' }
  it 'should load liferay components' do
    expect(chef_run).to run_execute 'sudo cp /vagrant/dist/*.war /opt/liferay/deploy'
  end
end
