require_relative File.join(Dir.pwd, '/libraries/plex_release_api')

describe Plex::ReleaseApi::Client do
  let(:http_client) { double('Net::HTTP') }
  let(:request) { double('Net::HTTP::Get') }
  let(:response) { double('response', body: File.open('spec/fixtures/1.json').read) }

  subject { described_class.new }

  before do
    allow(Net::HTTP).to receive(:new).with('plex.tv', 443).and_return(http_client)
    allow(Net::HTTP::Get).to receive(:new).and_return(request)
    expect(http_client).to receive(:use_ssl=).with(true)
    allow(http_client).to receive(:request).with(request).and_return(response)
  end

  describe '#pms_releases' do
    it 'has the windows i386 link' do
      expect(subject.pms_releases['windows']['i386']).to eq('https://downloads.plex.tv/plex-media-server/1.1.4.2757-24ffd60/Plex-Media-Server-1.1.4.2757-24ffd60-en-US.exe')
    end

    it 'has the windows x86_64 link' do
      expect(subject.pms_releases['windows']['x86_64']).to eq('https://downloads.plex.tv/plex-media-server/1.1.4.2757-24ffd60/Plex-Media-Server-1.1.4.2757-24ffd60-en-US.exe')
    end

    it 'has the mac_os_x x86_64 link' do
      expect(subject.pms_releases['mac_os_x']['x86_64']).to eq('https://downloads.plex.tv/plex-media-server/1.1.4.2757-24ffd60/PlexMediaServer-1.1.4.2757-24ffd60-OSX.zip')
    end

    it 'has the debian x86_64 link' do
      expect(subject.pms_releases['debian']['x86_64']).to eq('https://downloads.plex.tv/plex-media-server/1.1.4.2757-24ffd60/plexmediaserver_1.1.4.2757-24ffd60_amd64.deb')
    end

    it 'has the debian i686 link' do
      expect(subject.pms_releases['debian']['i686']).to eq('https://downloads.plex.tv/plex-media-server/1.1.4.2757-24ffd60/plexmediaserver_1.1.4.2757-24ffd60_i386.deb')
    end

    it 'has the fedora x86_64 link' do
      expect(subject.pms_releases['fedora']['x86_64']).to eq('https://downloads.plex.tv/plex-media-server/1.1.4.2757-24ffd60/plexmediaserver-1.1.4.2757-24ffd60.x86_64.rpm')
    end

    it 'has the fedora i686 link' do
      expect(subject.pms_releases['fedora']['i686']).to eq('https://downloads.plex.tv/plex-media-server/1.1.4.2757-24ffd60/plexmediaserver-1.1.4.2757-24ffd60.i386.rpm')
    end

    it 'has the rhel x86_64 link' do
      expect(subject.pms_releases['rhel']['x86_64']).to eq('https://downloads.plex.tv/plex-media-server/1.1.4.2757-24ffd60/plexmediaserver-1.1.4.2757-24ffd60.x86_64.rpm')
    end

    it 'has the rhel i686 link' do
      expect(subject.pms_releases['rhel']['i686']).to eq('https://downloads.plex.tv/plex-media-server/1.1.4.2757-24ffd60/plexmediaserver-1.1.4.2757-24ffd60.i386.rpm')
    end

    it 'has the freebsd x86_64 link' do
      expect(subject.pms_releases['freebsd']['x86_64']).to eq('https://downloads.plex.tv/plex-media-server/1.1.4.2757-24ffd60/PlexMediaServer-1.1.4.2757-24ffd60-freebsd-amd64.tar.bz2')
    end
  end
end
