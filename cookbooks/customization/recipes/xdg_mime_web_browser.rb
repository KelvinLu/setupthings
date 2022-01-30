#
# Cookbook:: customization
# Recipe:: xdg_mime_web_browser
#
# Copyright:: 2022, The Authors, All Rights Reserved.

MIMETYPES_WEB_BROWSER = %w[
  x-scheme-handler/http
  x-scheme-handler/https
  x-scheme-handler/ftp
  x-scheme-handler/chrome
  text/html
  application/x-extension-htm
  application/x-extension-html
  application/x-extension-shtml
  application/xhtml+xml
  application/x-extension-xhtml
  application/x-extension-xht
]

node['customization']&.[]('xdg_mime').each do |user, all_configs|
  config        = all_configs.fetch('web_browser')
  desktop_entry = config.fetch('desktop_entry')
  application   = File.basename(desktop_entry)
  recipe_name   = config.fetch('include_recipe', nil)

  include_recipe(recipe_name) unless recipe_name.nil?

  execute "set xdg-mime default for web browser #{application}" do
    command ['xdg-mime', 'default', application, *MIMETYPES_WEB_BROWSER]

    user    user
    login   true

    only_if { File.exist?(desktop_entry) }
  end

  execute "set xdg-settings default-web-browser #{application}" do
    command ['xdg-settings', 'set', 'default-web-browser', application]

    user    user
    login   true

    only_if { File.exist?(desktop_entry) }
  end
end
