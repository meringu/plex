arch = node['kernel']['machine']
platform_family = node['platform_family']
installer_file = "#{Chef::Config[:file_cache_path]}/plex_installer"
client = Plex::ReleaseApi::Client.new(channel: node['plex']['channel'],
                                      plex_token: node['plex']['token'])

remote_file installer_file do
  source client.pms_releases[platform_family][arch]
  action :create
end

case node['platform_family']
when 'debian'
  dpkg_package installer_file
when 'fedora', 'rhel'
  rpm_package installer_file
end

service 'plexmediaserver' do
  provider Object.const_get(node['plex']['service_provider']) unless node['plex']['service_provider'].nil?
  action [:enable, :start]
end
