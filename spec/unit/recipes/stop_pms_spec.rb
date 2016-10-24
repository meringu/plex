require 'chefspec'

describe 'plex::stop_pms' do
  let(:chef_run) { ChefSpec::SoloRunner.new(platform: 'ubuntu', version: '16.04') }

  it 'should stop plex media server' do
    chef_run.converge(described_recipe)
    expect(chef_run).to stop_plex_media_server('pms')
  end
end
