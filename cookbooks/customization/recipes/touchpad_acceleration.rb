#
# Cookbook:: customization
# Recipe:: touchpad_acceleration
#
# Copyright:: 2022, The Authors, All Rights Reserved.

file '/etc/X11/xorg.conf.d/50-touchpad-acceleration.conf' do
  content <<~EOF
    Section "InputClass"
        Identifier "touchpad"
        Driver "libinput"
        MatchIsTouchpad "on"

        Option "AccelProfile" "flat"
        Option "AccelSpeed" "0.3"
    EndSection
  EOF

  mode '0644'

  action :create
end
