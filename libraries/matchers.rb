if defined?(ChefSpec)
  ChefSpec.define_matcher :plex_media_server

  #
  # Used to verify whether a plex_media_server resource has been defined
  #
  # @example To check plex media server will installed
  #   expect(chef_run).to _plex_media_server('foo')
  #
  # @param [String] resource_name
  #   the resource name
  #
  # @return [ChefSpec::Matchers::ResourceMatcher]
  #
  def install_plex_media_server(resource_name)
    ChefSpec::Matchers::ResourceMatcher.new(:plex_media_server, :install, resource_name)
  end

  #
  # Used to verify whether a plex_media_server resource has been defined
  #
  # @example To check plex media server will installed and started
  #   expect(chef_run).to install_and_start_plex_media_server('foo')
  #
  # @param [String] resource_name
  #   the resource name
  #
  # @return [ChefSpec::Matchers::ResourceMatcher]
  #
  def install_and_start_plex_media_server(resource_name)
    ChefSpec::Matchers::ResourceMatcher.new(:plex_media_server, :install_and_start, resource_name)
  end

  #
  # Used to verify whether a plex_media_server resource has been defined
  #
  # @example To check plex media server will uninstalled
  #   expect(chef_run).to uninstall_plex_media_server('foo')
  #
  # @param [String] resource_name
  #   the resource name
  #
  # @return [ChefSpec::Matchers::ResourceMatcher]
  #
  def uninstall_plex_media_server(resource_name)
    ChefSpec::Matchers::ResourceMatcher.new(:plex_media_server, :uninstall, resource_name)
  end

  #
  # Used to verify whether a plex_media_server resource has been defined
  #
  # @example To check plex media server will started
  #   expect(chef_run).to start_plex_media_server('foo')
  #
  # @param [String] resource_name
  #   the resource name
  #
  # @return [ChefSpec::Matchers::ResourceMatcher]
  #
  def start_plex_media_server(resource_name)
    ChefSpec::Matchers::ResourceMatcher.new(:plex_media_server, :start, resource_name)
  end

  #
  # Used to verify whether a plex_media_server resource has been defined
  #
  # @example To check plex media server will stopped
  #   expect(chef_run).to stop_plex_media_server('foo')
  #
  # @param [String] resource_name
  #   the resource name
  #
  # @return [ChefSpec::Matchers::ResourceMatcher]
  #
  def stop_plex_media_server(resource_name)
    ChefSpec::Matchers::ResourceMatcher.new(:plex_media_server, :stop, resource_name)
  end

  #
  # Used to verify whether a plex_media_server resource has been defined
  #
  # @example To check plex media server will restarted
  #   expect(chef_run).to restart_plex_media_server('foo')
  #
  # @param [String] resource_name
  #   the resource name
  #
  # @return [ChefSpec::Matchers::ResourceMatcher]
  #
  def restart_plex_media_server(resource_name)
    ChefSpec::Matchers::ResourceMatcher.new(:plex_media_server, :restart, resource_name)
  end

  #
  # Used to verify whether a plex_media_server resource has been defined
  #
  # @example To check plex media server will enabled
  #   expect(chef_run).to enable_plex_media_server('foo')
  #
  # @param [String] resource_name
  #   the resource name
  #
  # @return [ChefSpec::Matchers::ResourceMatcher]
  #
  def enable_plex_media_server(resource_name)
    ChefSpec::Matchers::ResourceMatcher.new(:plex_media_server, :enable, resource_name)
  end

  #
  # Used to verify whether a plex_media_server resource has been defined
  #
  # @example To check plex media server will disabled
  #   expect(chef_run).to disable_plex_media_server('foo')
  #
  # @param [String] resource_name
  #   the resource name
  #
  # @return [ChefSpec::Matchers::ResourceMatcher]
  #
  def disable_plex_media_server(resource_name)
    ChefSpec::Matchers::ResourceMatcher.new(:plex_media_server, :disable, resource_name)
  end

end
