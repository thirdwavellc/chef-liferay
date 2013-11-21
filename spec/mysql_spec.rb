require 'chefspec'

describe 'liferay::mysql' do
  let (:chef_run) { ChefSpec::Runner.new(platform: 'ubuntu', version: '12.04').converge 'liferay::mysql' }
  it 'should do something' do
    pending 'Your recipe examples go here.'
  end
end
