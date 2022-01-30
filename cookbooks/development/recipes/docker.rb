#
# Cookbook:: development
# Recipe:: docker
#
# Copyright:: 2022, The Authors, All Rights Reserved.

require 'json'

pacman_package 'docker' do
  action :install
end

directory '/etc/docker/' do
  mode '0755'
end

file '/etc/docker/daemon.json' do
  content "{\n}\n"

  mode    '0644'

  action  :create_if_missing
end

data_root = node['development']&.[]('docker')&.[]('data-root')

directory data_root do
  mode '0710'

  not_if { File.directory?(data_root) }
end

ruby_block 'set /etc/docker/daemon.json data-root' do
  block do
    File.open('/etc/docker/daemon.json', 'w+') do |file|
      config = JSON.load(file.read) || {}
      config['data-root'] = data_root
      file.write(JSON.dump(config))
    end
  end

  not_if { data_root == File.open('/etc/docker/daemon.json', 'r') { |file| JSON.load(file.read)&.[]('data-root') } }
end
