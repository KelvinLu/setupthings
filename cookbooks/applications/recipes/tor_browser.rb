#
# Cookbook:: applications
# Recipe:: tor_browser
#
# Copyright:: 2022, The Authors, All Rights Reserved.

pacman_package 'torbrowser-launcher' do
  action :install
end

pacman_package 'torsocks' do
  action :install
end

ruby_block 'configure /etc/tor/torsocks.conf' do
  block do
    file = Chef::Util::FileEdit.new('/etc/tor/torsocks.conf')

    config_line = 'TorPort 9150'
    file.search_file_replace_line(/^TorPort/, config_line)
    file.insert_line_if_no_match(/^TorPort/, config_line)

    file.write_file
  end
end
