require 'chefspec'

describe 'liferay::mysql' do
  let (:chef_run) { ChefSpec::ChefRunner.new.converge 'liferay::mysql' }
  it 'should do something' do
    pending 'Your recipe examples go here.'
  end
end
