#
# Cookbook:: ssh_user
# Recipe:: agent
#
# Copyright:: 2022, The Authors, All Rights Reserved.

ssh_user_each do |username, user_info|
  systemd_unit 'ssh-agent.service' do
    content <<~EOF
      [Unit]
      Description=SSH key agent

      [Service]
      Type=simple
      Environment=SSH_AUTH_SOCK=%t/ssh-agent.sock
      ExecStart=/usr/bin/ssh-agent -D -a $SSH_AUTH_SOCK

      [Install]
      WantedBy=default.target
    EOF

    user    username

    action  [:create, :enable, :start]
  end

  ssh_dir     = File.join(user_info[:dir], '.ssh')
  ssh_config  = File.join(ssh_dir, 'config')

  directory ssh_dir do
    owner   username
    group   user_info[:gid]
    mode    '0700'
    action  :create
  end

  file ssh_config do
    owner   username
    group   user_info[:gid]
    mode    '0600'
    action  :create_if_missing
  end

  ruby_block 'configure option for keys to be added to SSH agent' do
    block do
      Chef::Util::FileEdit.new(ssh_config).tap do |config|
        line = 'AddKeysToAgent ask'
        config.insert_line_if_no_match(/#{Regexp.escape(line)}/, line)
        config.write_file
      end
    end

    action :run
  end
end
