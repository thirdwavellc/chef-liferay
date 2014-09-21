require 'chefspec'

describe 'liferay::plugins' do
  let (:chef_run) { ChefSpec::Runner.new(platform: 'ubuntu', version: '12.04').converge('liferay::plugins') }

  it 'should install the plugins' do
    expect(chef_run).to run_bash("Install marketplace plugins")
  end
end
