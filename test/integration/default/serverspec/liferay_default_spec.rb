require 'serverspec'

set :backend, :exec

describe 'liferay' do
  describe 'user' do
    let(:liferay_user) { user('liferay') }

    it 'should exist' do
      expect(liferay_user).to exist
    end

    it 'should belong to liferay group' do
      expect(liferay_user).to belong_to_group('liferay')
    end
  end

  describe 'group' do
    let(:liferay_group) { group('liferay') }

    it 'should exist' do
      expect(liferay_group).to exist
    end
  end

  describe 'deploy directory' do
    let(:liferay_dir) { file('/opt/liferay') }

    it 'should exist' do
      expect(liferay_dir).to be_directory
    end

    it 'should be owned by liferay' do
      expect(liferay_dir).to be_owned_by('liferay')
    end

    it 'should be grouped into liferay' do
      expect(liferay_dir).to be_grouped_into('liferay')
    end
  end

  describe 'init script' do
    let(:init_script) { file('/etc/init.d/liferay') }

    it 'should exist' do
      expect(init_script).to be_file
    end
  end

  describe 'logrotate' do
    let(:logrotate) { file('/etc/logrotate.d/liferay') }

    it 'should exist' do
      expect(logrotate).to be_file
    end
  end

  describe 'service' do
    let(:liferay) { service('liferay') }

    it 'should be enabled' do
      expect(liferay).to be_enabled
    end
  end
end
