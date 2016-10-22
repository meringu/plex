actions :install,
        :install_and_start,
        :uninstall,
        :start,
        :stop,
        :restart,
        :enable,
        :disable

default_action :install_and_start

attribute :channel, kind_of: String
attribute :token, kind_of: String
attribute :service_provider, kind_of: String
