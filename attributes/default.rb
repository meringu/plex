# Leave as nil for public channel; plexpass for plex pass channel
default['plex']['channel'] = nil

# Must be set if channel is set to plexpass
default['plex']['token'] = nil

# The name of the provider class for the service, leave nil to use the Chef default
default['plex']['service_provider'] = nil
