#
# Cookbook:: applications
# Recipe:: zip
#
# Copyright:: 2022, The Authors, All Rights Reserved.

pacman_package 'zip' do
  action :install
end

pacman_package 'unzip' do
  action :install
end
