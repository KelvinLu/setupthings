#
# Cookbook:: applications
# Recipe:: tailscale
#
# Copyright:: 2022, The Authors, All Rights Reserved.

pacman_package 'tailscale' do
  action :install
end

systemd_unit 'tailscaled.service' do
  action [:enable, :start]
end
