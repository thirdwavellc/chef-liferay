require 'chefspec'

describe 'liferay::load_marketplace_lpkgs' do
  let (:chef_run) { ChefSpec::ChefRunner.new.converge 'liferay::load_marketplace_lpkgs' }
  it 'should load marketplace lpkgs' do
    expect(chef_run).to execute_bash_script 'load-marketplace-lpkgs'
  end
end
