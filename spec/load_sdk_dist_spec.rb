require 'chefspec'

describe 'liferay::load_sdk_dist' do
  let (:chef_run) { ChefSpec::ChefRunner.new.converge 'liferay::load_sdk_dist' }
  it 'should load liferay components' do
    expect(chef_run).to execute_command 'sudo cp /vagrant/dist/*.war /opt/liferay/deploy'
  end
end
