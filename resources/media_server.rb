actions :install,
        :uninstall,
        :start,
        :stop,
        :restart,
        :enable,
        :disable

default_action [:install, :start, :enable]

attribute :channel, kind_of: String
attribute :token, kind_of: String
attribute :service_provider, kind_of: String
attribute :source, kind_of: String
