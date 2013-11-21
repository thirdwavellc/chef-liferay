require 'chefspec'

describe 'liferay::patches' do
  let (:chef_run) { ChefSpec::Runner.new(platform: 'ubuntu', version: '12.04').converge 'liferay::patches' }
  it 'should do something' do
    pending 'Your recipe examples go here.'
  end
end
