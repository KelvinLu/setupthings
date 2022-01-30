#
# Cookbook:: applications
# Recipe:: vim_ycm_compile
#
# Copyright:: 2022, The Authors, All Rights Reserved.

require 'etc'

include_recipe 'applications::vim_plug_install'

node['applications']&.[]('vim_plug_install')&.[]('users').each do |user|
  ycm_dir = File.join(Dir.home(user), '.vim', 'plugged', 'youcompleteme')

  log 'no ~/.vim/plugged/youcompleteme/' do
    message "Could not find ~/.vim/plugged/youcompleteme/ for user #{user}"
    level   :error

    not_if  { File.directory?(ycm_dir) }
  end

  pacman_package 'cmake' do
    action :install
  end

  execute "compile youcompleteme" do
    command ['python', File.join(ycm_dir, 'install.py'), '--force-sudo']
    cwd     ycm_dir
    user    user
    group   Etc.getpwnam(user)[:gid]

    only_if  { File.directory?(ycm_dir) && Dir.glob(File.join(ycm_dir, 'third_party', 'ycmd', 'ycm_core*.so*')).none? }
  end
end
