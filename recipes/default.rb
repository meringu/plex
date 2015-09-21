#
# Cookbook Name:: plex
# Recipe:: default
#
# Copyright 2015, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

distro = ''
if node[:platform_family].include?('rhel')
  distro = 'CentOS'
elsif node[:platform_family].include?('fedora')
  distro = 'Fedora'
elsif node[:platform_family].include?('debian')
  distro = 'Ubuntu'
else
  raise
end
bits = node['kernel']['machine'] =~ /64/ ? 64 : 32

lines = open('https://plex.tv/downloads').read
a = /http.+#{distro}.+#{bits}-bit<\/a>/.match(lines)
href = a.to_s.gsub /<.+href="|" class.+/, ''
file = "#{Chef::Config[:file_cache_path]}/#{href.gsub /.+\//, ''}"

remote_file file do
  source href
  action :create
end

if node[:platform_family].include?('rhel') || node[:platform_family].include?('fedora')
  rpm_package file
elsif node[:platform_family].include?('debian')
  dpkg_package file
end
