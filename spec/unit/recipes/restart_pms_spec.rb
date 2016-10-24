require 'chefspec'

describe 'plex::restart_pms' do
    let(:chef_run) { ChefSpec::SoloRunner.new(platform: 'ubuntu', version: '16.04') }

  it 'should restart plex media server' do
    chef_run.converge(described_recipe)
    expect(chef_run).to restart_plex_media_server('pms')
  end
end
