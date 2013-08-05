require 'chefspec'

describe 'liferay::plugins' do
  let (:chef_run) { ChefSpec::ChefRunner.new.converge 'liferay::plugins' }
  it 'should do something' do
    pending 'Your recipe examples go here.'
  end
end
