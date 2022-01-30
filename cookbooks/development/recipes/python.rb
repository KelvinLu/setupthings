#
# Cookbook:: development
# Recipe:: python
#
# Copyright:: 2022, The Authors, All Rights Reserved.

pacman_package 'python' do
  action :install
end

pacman_package 'pyenv' do
  action :install
end

pacman_group 'base-devel' do
  action :install

  options '--needed'
end

pacman_package ['openssl', 'zlib', 'xz'] do
  action :install

  options '--needed'
end

pacman_package ['python-pip', 'python-virtualenv', 'python-pipenv'] do
  action :install
end
