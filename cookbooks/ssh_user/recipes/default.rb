#
# Cookbook:: ssh_user
# Recipe:: default
#
# Copyright:: 2022, The Authors, All Rights Reserved.

require 'etc'

ssh_user_each do |username, user_info|
  ssh_dir = File.join(user_info[:dir], '.ssh')

  directory ssh_dir do
    owner   username
    group   user_info[:gid]
    mode    '0700'
    action  :create
  end

  execute 'create SSH keypair' do
    command ['ssh-keygen', '-q', '-t', 'ed25519', '-N', '', '-f', File.join(ssh_dir, 'id_ed25519'), '-C', "#{username}@#{node.name}"]
    cwd     ssh_dir
    user    username
    group   user_info[:gid]

    creates File.join(ssh_dir, 'id_ed25519')
  end
end
