require 'chefspec'

describe 'liferay::enterprise' do
  let (:chef_run) do
    runner = ChefSpec::Runner.new(platform: 'ubuntu', version: '12.04') do |node|
      node.set['liferay']['ee']['license_url'] = "http://www.example.com/license"
    end.converge(described_recipe)
  end

  before do
    stub_command("update-alternatives --display java | grep '/usr/lib/jvm/java-6-openjdk-amd64/jre/bin/java - priority 1061'").and_return(true)
  end

  it 'should include the liferay::default' do
    expect(chef_run).to include_recipe 'liferay::default'
  end
end
