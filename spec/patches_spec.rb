require 'chefspec'

describe 'liferay::patches' do
  let (:chef_run) { ChefSpec::Runner.new(platform: 'ubuntu', version: '12.04').converge(described_recipe) }

  describe 'when a patching tool is specified' do
    let (:chef_run) do
      ChefSpec::Runner.new(platform: 'ubuntu', version: '12.04') do |node|
        node.set['liferay']['ee']['patching_tool_zip'] = 'patching-tool.zip'
      end.converge('liferay::patches')
    end

    it 'should delete the existing patching tool' do
      expect(chef_run).to delete_directory('/opt/liferay/patching-tool')
    end

    it 'should copy the new patching tool' do
      expect(chef_run).to run_execute('copy over patching tool patching-tool.zip')
    end

    it 'should extract the new patching tool' do
      expect(chef_run).to run_execute('extract patching-tool.zip')
    end
  end

  it 'should copy the patches' do
    expect(chef_run).to run_execute('copy over patches')
  end

  it 'should create the patching tool properties template' do
    expect(chef_run).to create_template('/opt/liferay/patching-tool/default.properties')
  end

  it 'should run the patching tool' do
    expect(chef_run).to run_execute('patching tool install')
  end
end
