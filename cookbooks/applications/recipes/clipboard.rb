#
# Cookbook:: applications
# Recipe:: clipboard
#
# Copyright:: 2022, The Authors, All Rights Reserved.

pacman_package 'xsel' do
  action :install
end
