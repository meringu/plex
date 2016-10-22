control 'Plex-plexmediaserver' do
  impact 1.0
  title 'The plexmediaserver service is running'

  describe package('plexmediaserver') do
    it { should be_installed }
  end

  describe service('plexmediaserver') do
    it { should be_installed }
    it { should_not be_enabled }
    it { should_not be_running }
  end
end
