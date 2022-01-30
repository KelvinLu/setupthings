#
# Cookbook:: applications
# Recipe:: playerctl
#
# Copyright:: 2022, The Authors, All Rights Reserved.

pacman_package 'playerctl' do
  action :install
end
