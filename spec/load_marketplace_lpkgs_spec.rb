require 'chefspec'

describe 'liferay::load_marketplace_lpkgs' do
  let (:chef_run) { ChefSpec::Runner.new(platform: 'ubuntu', version: '12.04').converge 'liferay::load_marketplace_lpkgs' }
  it 'should load marketplace lpkgs' do
    expect(chef_run).to run_bash 'load-marketplace-lpkgs'
  end
end
