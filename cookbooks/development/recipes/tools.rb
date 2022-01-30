#
# Cookbook:: development
# Recipe:: tools
#
# Copyright:: 2022, The Authors, All Rights Reserved.

pacman_package 'strace' do
  action :install
end

pacman_package 'lsof' do
  action :install
end

pacman_package 'gnu-netcat' do
  action :install
end

pacman_package 'socat' do
  action :install
end

pacman_package 'net-tools' do
  action :install
end

pacman_package 'traceroute' do
  action :install
end
