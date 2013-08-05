require 'chefspec'

describe 'liferay::enterprise' do
  let (:chef_run) do
    runner = ChefSpec::ChefRunner.new
    runner.node.set['liferay']['ee']['license_url'] = "http://www.example.com/license"
    runner.converge 'liferay::enterprise'
  end
  it 'should include the liferay::default' do
    expect(chef_run).to include_recipe 'liferay::default'
  end
end
