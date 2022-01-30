# setupthings

Chef repository for provisioning my very own personal system

> _see also: https://github.com/KelvinLu/configthings_

## Caveats

- Although the usage of Chef `Policyfile`s is preferred when managing Cookbook dependencies, `chef-solo` (`chef-client` in local mode) is a community-maintained provisioner that does not yet have support for them. Instead, we will use Berkshelf.

## Prerequisites

1. Obtain a computer, install Manjaro as the operating system.
    - This specific system uses Manjaro's _i3 Community Edition_.
2. Perform any necessary basic, manual setup.
    - e.g.; creating a user account, issuing new SSH keypairs, installing Git ...
3. Install [Chef Workstation](https://github.com/chef/chef-workstation).
    - `yay -S chef-workstation --noconfirm`, `chef --version`.
    - See [`chef shell-init`](https://docs.chef.io/workstation/ctl_chef/#chef-shell-init) on how to use Chef's embedded Ruby.
4. Bootstrap configuration.
    1. Clone this repository.
    2. Vend cookbooks managed by Berkshelf.
        - `berks vendor --berksfile ./nodes/{filename:?}.berksfile ./berkshelf/`
5. Run `chef-solo`.
    - See `chef-solo`'s [documentation](https://docs.chef.io/chef_solo/) and [executable reference](https://docs.chef.io/ctl_chef_solo/).
    - `chef-solo --config ./solo.rb --json-attributes ./nodes/{filename:?}.json`.
    - `chef-solo --config ./solo.rb --json-attributes ./nodes/{filename:?}.json --override-runlist "${run_list:?}"`.
