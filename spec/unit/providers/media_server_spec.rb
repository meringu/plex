require 'chefspec'
require_relative File.join(Dir.pwd, '/libraries/plex_release_api')

describe 'plex_media_server' do
  let(:file_cache_path) { '/var/chef/cahce' }

  let(:download_link) do
    if platform == 'ubuntu'
      'https://plex.tv/downloads/ubuntu/plexmediaserver.deb'
    elsif platform == 'fedora'
      'https://plex.tv/downloads/fedora/plexmediaserver.rpm'
    elsif platform == 'centos'
      'https://plex.tv/downloads/rhel/plexmediaserver.rpm'
    end
  end

  let(:plex_release_api_client) { double('Plex::ReleaseApi::Client') }

  let(:chef_run) do
    ChefSpec::SoloRunner.new(
      platform: platform,
      version: version,
      step_into: ['plex_media_server'],
      file_cache_path: file_cache_path
    ).converge("plex::#{action}_pms")
  end

  before do
    allow(Plex::ReleaseApi::Client).to receive(:new).and_return(plex_release_api_client)
    allow(plex_release_api_client).to receive(:pms_releases).and_return(
      {
        'rhel' => {
          'x86_64' => 'https://plex.tv/downloads/rhel/plexmediaserver.rpm'
        },
        'fedora' => {
          'x86_64' => 'https://plex.tv/downloads/fedora/plexmediaserver.rpm'
        },
        'debian' => {
          'x86_64' => 'https://plex.tv/downloads/ubuntu/plexmediaserver.deb'
        }
      }
    )
  end

  shared_examples_for 'plex_media_server' do
    context 'action :install' do
      let(:action) { 'install' }

      it 'should install plex media server' do
        if platform == 'ubuntu'
          expect(chef_run).to create_remote_file('/var/chef/cahce/plexmediaserver.deb').with(source: download_link)
          expect(chef_run).to install_dpkg_package('/var/chef/cahce/plexmediaserver.deb')
        else
          expect(chef_run).to create_remote_file('/var/chef/cahce/plexmediaserver.rpm').with(source: download_link)
          expect(chef_run).to install_rpm_package('/var/chef/cahce/plexmediaserver.rpm')
        end
      end
    end

    context 'action :uninstall' do
      let(:action) { 'uninstall' }

      it 'should uninstall plex media server' do
        if platform == 'ubuntu'
          expect(chef_run).to purge_dpkg_package('plexmediaserver')
        else
          expect(chef_run).to remove_rpm_package('plexmediaserver')
        end
      end
    end

    context 'action :disable' do
      let(:action) { 'disable' }

      it 'should disable the service' do
        expect(chef_run).to disable_service('plexmediaserver')
      end
    end

    context 'action :enable' do
      let(:action) { 'enable' }

      it 'should enable the service' do
        expect(chef_run).to enable_service('plexmediaserver')
      end
    end

    context 'action :restart' do
      let(:action) { 'restart' }

      it 'should restart the service' do
        expect(chef_run).to restart_service('plexmediaserver')
      end
    end

    context 'action :start' do
      let(:action) { 'start' }

      it 'should start the service' do
        expect(chef_run).to start_service('plexmediaserver')
      end
    end

    context 'action :stop' do
      let(:action) { 'stop' }

      it 'should stop the service' do
        expect(chef_run).to stop_service('plexmediaserver')
      end
    end
  end

  context 'ubuntu' do
    let(:platform) { 'ubuntu' }
    let(:version) { '16.04' }

    it_should_behave_like 'plex_media_server'
  end

  context 'fedora' do
    let(:platform) { 'fedora' }
    let(:version) { '24' }

    it_should_behave_like 'plex_media_server'
  end

  context 'centos' do
    let(:platform) { 'centos' }
    let(:version) { '7.2.1511' }

    it_should_behave_like 'plex_media_server'
  end
end
