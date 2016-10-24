require 'chefspec'

describe 'plex::default' do
  context 'defaults' do
    let(:chef_run) { ChefSpec::SoloRunner.new(platform: 'ubuntu', version: '16.04') }

    it 'should install, start, and enable plex media server' do
      chef_run.converge(described_recipe)
      expect(chef_run).to install_plex_media_server('pms').with(channel: nil, token: nil, service_provider: nil, source: nil)
      expect(chef_run).to start_plex_media_server('pms').with(channel: nil, token: nil, service_provider: nil, source: nil)
      expect(chef_run).to enable_plex_media_server('pms').with(channel: nil, token: nil, service_provider: nil, source: nil)
    end
  end

  context 'overrides' do
    let(:chef_run) do
      ChefSpec::SoloRunner.new(platform: 'ubuntu', version: '16.04') do |node|
        node.override['plex']['channel'] = 'channel'
        node.override['plex']['token'] = 'token'
        node.override['plex']['service_provider'] = 'service_provider'
        node.override['plex']['source'] = 'source'
      end
    end

    it 'should install, start, and enable plex media server' do
      chef_run.converge(described_recipe)
      expect(chef_run).to install_plex_media_server('pms').with(channel: 'channel', token: 'token', service_provider: 'service_provider', source: 'source')
      expect(chef_run).to start_plex_media_server('pms').with(channel: 'channel', token: 'token', service_provider: 'service_provider', source: 'source')
      expect(chef_run).to enable_plex_media_server('pms').with(channel: 'channel', token: 'token', service_provider: 'service_provider', source: 'source')
    end
  end
end
