require 'spec_helper'

describe 'liferay::default' do
  let(:chef_run) do
    ChefSpec::SoloRunner
      .new(platform: 'ubuntu',
           version: '14.04',
           step_into: ['liferay_app'])
      .converge(described_recipe)
  end
  let(:liferay_init_template) { chef_run.template('/etc/init.d/liferay') }
  let(:liferay_service) { chef_run.service('liferay') }

  it 'should create liferay_app[liferay_app]' do
    expect(chef_run).to create_liferay_app 'liferay_app'
  end

  it 'should include apt::default' do
    expect(chef_run).to include_recipe 'apt::default'
  end

  it 'should include imagemagick::default' do
    expect(chef_run).to include_recipe 'imagemagick::default'
  end

  it 'should include java::default' do
    expect(chef_run).to include_recipe 'java::default'
  end

  it 'should create the liferay user' do
    expect(chef_run).to create_user 'liferay'
  end

  it 'should do nothing with liferay service (until notified)' do
    expect(liferay_service).to do_nothing
  end

  it 'should create liferay init script' do
    expect(chef_run).to render_file '/etc/init.d/liferay'
  end

  it 'should notify service[liferay] to enable' do
    expect(liferay_init_template).to notify('service[liferay]').to(:enable)
  end

  it 'should create the liferay logrotate' do
    expect(chef_run).to render_file '/etc/logrotate.d/liferay'
  end

  it 'should create the liferay deploy directory' do
    expect(chef_run).to create_directory '/opt/liferay'
  end
end
