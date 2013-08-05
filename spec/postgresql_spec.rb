require 'chefspec'

describe 'liferay::postgresql' do
  let (:chef_run) { ChefSpec::ChefRunner.new.converge 'liferay::postgresql' }
  it 'should do something' do
    pending 'Your recipe examples go here.'
  end
end
