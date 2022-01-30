#
# Cookbook:: applications
# Recipe:: timedatectl
#
# Copyright:: 2022, The Authors, All Rights Reserved.

systemd_unit 'systemd-timesyncd.service' do
  action [:enable, :start]
end

execute 'timedatectl set-ntp true' do
  command ['timedatectl', 'set-ntp', 'true']
end
