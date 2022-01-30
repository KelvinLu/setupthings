#
# Cookbook:: configthings
# Recipe:: stow_bash_profile
#
# Copyright:: 2022, The Authors, All Rights Reserved.

require 'etc'

include_recipe 'configthings::default'

node['configthings']&.select { |parameters| parameters['stow_bash_profile'] }&.each do |parameters|
  home_dir          = Dir.home(parameters['user'])
  bash_profile      = File.join(home_dir, '.bash_profile')
  bashrc            = File.join(home_dir, '.bashrc')
  sh_profile        = File.join(home_dir, '.profile')
  bash_profile_orig = File.join(home_dir, '.bash_profile.orig')
  bashrc_orig       = File.join(home_dir, '.bashrc.orig')
  sh_profile_orig   = File.join(home_dir, '.profile.orig')
  bash_profile_stow = File.join(home_dir, '.bash_profile.stow')
  bashrc_stow       = File.join(home_dir, '.bashrc.stow')
  sh_profile_stow   = File.join(home_dir, '.profile.stow')

  file bash_profile_orig do
    content lazy { File.open(bash_profile).read }

    owner   parameters['user']
    group   Etc.getpwnam(parameters['user'])[:gid]
    mode    '0644'

    action  :create
    not_if  { File.exist?(bash_profile_orig) }
  end

  file bashrc_orig do
    content lazy { File.open(bashrc).read }

    owner   parameters['user']
    group   Etc.getpwnam(parameters['user'])[:gid]
    mode    '0644'

    action  :create
    not_if  { File.exist?(bashrc_orig) }
  end

  file sh_profile_orig do
    content lazy { File.open(sh_profile).read }

    owner   parameters['user']
    group   Etc.getpwnam(parameters['user'])[:gid]
    mode    '0644'

    action  :create
    not_if  { File.exist?(sh_profile_orig) }
  end

  link bash_profile do
    to bash_profile_stow

    owner   parameters['user']
    group   Etc.getpwnam(parameters['user'])[:gid]
    mode    '0644'

    only_if { File.file?(bash_profile_stow) }
  end

  link bashrc do
    to bashrc_stow

    owner   parameters['user']
    group   Etc.getpwnam(parameters['user'])[:gid]
    mode    '0644'

    only_if { File.file?(bashrc_stow) }
  end

  link sh_profile do
    to sh_profile_stow

    owner   parameters['user']
    group   Etc.getpwnam(parameters['user'])[:gid]
    mode    '0644'

    only_if { File.file?(sh_profile_stow) }
  end
end
