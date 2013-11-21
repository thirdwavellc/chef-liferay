require 'chefspec'

describe 'liferay::enterprise' do
  let (:chef_run) do
    runner = ChefSpec::Runner.new(platform: 'ubuntu', version: '12.04') do |node|
      node.set['liferay']['ee']['license_url'] = "http://www.example.com/license"
    end.converge(described_recipe)
      end
  it 'should include the liferay::default' do
    expect(chef_run).to include_recipe 'liferay::default'
  end
end
