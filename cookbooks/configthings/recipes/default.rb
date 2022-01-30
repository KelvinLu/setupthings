#
# Cookbook:: configthings
# Recipe:: default
#
# Copyright:: 2022, The Authors, All Rights Reserved.

require 'etc'

CONFIGTHINGS_PARAMETERS = %i[user dir git ref stow]

node['configthings']&.each do |parameters|
  unless (CONFIGTHINGS_PARAMETERS - parameters.keys.map(&:to_sym)).empty?
    raise ArgumentError, "Missing full set of parameters: #{CONFIGTHINGS_PARAMETERS.join(', ')}"
  end

  git_dir = File.join(parameters['dir'], '.configthings-git/')

  directory git_dir do
    owner   parameters['user']
    group   Etc.getpwnam(parameters['user'])[:gid]
    mode    '0700'
    action  :create
  end

  git 'configthings repository' do
    destination git_dir

    repository  parameters['git']
    revision    parameters['ref']
    depth       1

    user        parameters['user']
    group       Etc.getpwnam(parameters['user'])[:gid]

    action      :sync
  end

  pacman_package 'stow' do
    action :install
  end

  parameters['stow']&.each do |package|
    execute "configthings stow #{package}" do
      command ['stow', '--restow', package]
      cwd     git_dir
      user    parameters['user']
      group   Etc.getpwnam(parameters['user'])[:gid]
    end
  end
end
