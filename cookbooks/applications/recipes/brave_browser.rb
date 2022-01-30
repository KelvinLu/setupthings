#
# Cookbook:: applications
# Recipe:: brave_browser
#
# Copyright:: 2022, The Authors, All Rights Reserved.

pacman_package 'brave-browser' do
  action :install
end
