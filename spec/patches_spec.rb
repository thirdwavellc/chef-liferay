require 'chefspec'

describe 'liferay::patches' do
  let (:chef_run) { ChefSpec::ChefRunner.new.converge 'liferay::patches' }
  it 'should do something' do
    pending 'Your recipe examples go here.'
  end
end
