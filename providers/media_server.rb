use_inline_resources

def whyrun_supported?
  true
end

def pms_source
  return @source unless @source.nil?
  return new_resource.source unless new_resource.source.nil?
  arch = node['kernel']['machine']
  platform_family = node['platform_family']
  installer_file = "#{Chef::Config[:file_cache_path]}/plex_installer"
  client = Plex::ReleaseApi::Client.new(channel: new_resource.channel,
                                        plex_token: new_resource.token)
  @source = client.pms_releases[platform_family][arch]
end

def do_service(action)
  service 'plexmediaserver' do
    provider Object.const_get(new_resource.service_provider) unless new_resource.service_provider.nil?
    action action
  end
end

action :install do
  file_name = pms_source.gsub(%r{.*/}, '')
  installer_file = "#{Chef::Config[:file_cache_path]}/#{file_name}"

  remote_file installer_file do
    source pms_source
    action :create
  end

  package installer_file do
    action :upgrade
    provider case node['platform_family']
    when 'debian'
      Chef::Provider::Package::Dpkg
    when 'fedora', 'rhel'
      Chef::Provider::Package::Rpm
    else
      raise "Unsupported platform_family #{node['platform_family']}"
    end
  end
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
