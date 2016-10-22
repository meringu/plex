plex_media_server 'pms' do
  channel node['plex']['channel']
  token node['plex']['token']
  service_provider node['plex']['service_provider']

  action :uninstall
end
