#
# Cookbook:: applications
# Recipe:: sshfs
#
# Copyright:: 2022, The Authors, All Rights Reserved.

pacman_package 'sshfs' do
  action :install
end
