use_inline_resources

def whyrun_supported?
  true
end

def install_pms
  arch = node['kernel']['machine']
  platform_family = node['platform_family']
  installer_file = "#{Chef::Config[:file_cache_path]}/plex_installer"
  client = Plex::ReleaseApi::Client.new(channel: new_resource.channel,
                                        plex_token: new_resource.token)

  release = client.pms_releases[platform_family][arch]

  installer_file = "#{Chef::Config[:file_cache_path]}/#{release['filename']}"

  remote_file installer_file do
    source release['url']
    action :create
  end

  case node['platform_family']
  when 'debian'
    dpkg_package installer_file
  when 'fedora', 'rhel'
    rpm_package installer_file
  else
    Chef::Application.fatal!("Unsuppoerted platform_family #{node['platform_family']}")
  end
end

def do_service(action)
  service 'plexmediaserver' do
    provider Object.const_get(new_resource.service_provider) unless new_resource.service_provider.nil?
    action action
  end
end

action :install do
  install_pms
  do_service [:disable, :stop]
end

action :install_and_start do
  install_pms
  do_service [:enable, :start]
end

action :uninstall do
  case node['platform_family']
  when 'debian'
    dpkg_package 'plexmediaserver' do
      action :purge
    end
  when 'fedora', 'rhel'
    rpm_package 'plexmediaserver' do
      action :remove
    end
  else
    Chef::Application.fatal!("Unsuppoerted platform_family #{node['platform_family']}")
  end
end

%i(
  disable
  enable
  restart
  start
  stop
).each do |a|
  action a do
    do_service(a)
  end
end
