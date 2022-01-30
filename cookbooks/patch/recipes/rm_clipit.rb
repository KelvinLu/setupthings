#
# Cookbook:: patch
# Recipe:: rm_clipit
#
# Copyright:: 2022, The Authors, All Rights Reserved.

# ClipIt by default reads the clipboard and saves unique entries to a history
# file, which is generally undesirable. Modern applications such as password
# managers and hardware two-factor authentication devices often use the
# clipboard as a means of carrying sensitive information.

include_recipe 'applications::clipboard'

pacman_package 'clipit' do
  action :purge
end
