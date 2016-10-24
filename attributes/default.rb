# Leave as nil for public channel; plexpass for plex pass channel
default['plex']['channel'] = nil

# Must be set if channel is set to plexpass
default['plex']['token'] = nil

# The name of the provider class for the service, leave nil to use the Chef default
default['plex']['service_provider'] = nil

# The location of the plex installer, leave nil to get the cookbook to look this up
default['plex']['source'] = nil
