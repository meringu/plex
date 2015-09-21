Vagrant.configure("2") do |config|
  config.vm.box = 'ubuntu/trusty64'
  config.vm.network "forwarded_port", guest: 32400, host: 32400
  config.vm.provision :chef_zero do |chef|
    chef.add_recipe 'plex'
  end
end
