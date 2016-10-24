require 'chefspec'

describe 'plex::disable_pms' do
    let(:chef_run) { ChefSpec::SoloRunner.new(platform: 'ubuntu', version: '16.04') }

  it 'should disable plex media server' do
    chef_run.converge(described_recipe)
    expect(chef_run).to disable_plex_media_server('pms')
  end
end
