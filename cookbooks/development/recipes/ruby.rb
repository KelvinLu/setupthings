#
# Cookbook:: development
# Recipe:: ruby
#
# Copyright:: 2022, The Authors, All Rights Reserved.

pacman_package 'ruby' do
  action :install
end

pacman_package ['ruby-irb', 'ruby-rdoc'] do
  action :install
end

pacman_aur 'chruby' do
  action :build
end

pacman_aur 'ruby-install' do
  action :build
end

# The `pacman_aur` `:install` implementation assumes the compressed package has
# a `.zst` extension in its calling arguments. `pacman`/`tar` can automatically
# detect the compression method, regardless of the file name.
['chruby', 'ruby-install'].each do |package_name|
  link "alias pacman package #{package_name}" do
    target_file lazy { file = find_built_packages(package_name).first; "#{file[:path].delete_suffix(file[:extension])}.zst" }
    to          lazy { File.basename(find_built_packages(package_name).first[:path]) }

    action      :nothing
    only_if     { find_built_packages(package_name).count == 1 }
  end
end

pacman_aur 'chruby' do
  action :install
  notifies :create, 'link[alias pacman package chruby]', :before
end

pacman_aur 'ruby-install' do
  action :install
  notifies :create, 'link[alias pacman package ruby-install]', :before
end

pacman_package 'ruby-bundler' do
  action :install
end
