#
# Cookbook:: development
# Recipe:: rust
#
# Copyright:: 2022, The Authors, All Rights Reserved.

pacman_package 'rustup' do
  action :install
end
