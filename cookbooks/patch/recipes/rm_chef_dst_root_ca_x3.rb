#
# Cookbook:: patch
# Recipe:: rm_chef_dst_root_ca_x3
#
# Copyright:: 2022, The Authors, All Rights Reserved.

# Chef's embedded CA file includes an expired certificate (DST Root CA X3).
# Chef also utilizes a version of OpenSSL (older than 1.1.0) that rejects such
# expired CAs, even if an alternative valid certificate chain is present. This
# sometimes interferes with Chef's own provisioning (for example, when
# connecting to AUR for manually downloading package files).
# See https://letsencrypt.org/docs/dst-root-ca-x3-expiration-september-2021/.

DST_ROOT_CA_X3 = <<~PEM_CERTIFICATE.strip
-----BEGIN CERTIFICATE-----
MIIDSjCCAjKgAwIBAgIQRK+wgNajJ7qJMDmGLvhAazANBgkqhkiG9w0BAQUFADA/MSQwIgYDVQQK
ExtEaWdpdGFsIFNpZ25hdHVyZSBUcnVzdCBDby4xFzAVBgNVBAMTDkRTVCBSb290IENBIFgzMB4X
DTAwMDkzMDIxMTIxOVoXDTIxMDkzMDE0MDExNVowPzEkMCIGA1UEChMbRGlnaXRhbCBTaWduYXR1
cmUgVHJ1c3QgQ28uMRcwFQYDVQQDEw5EU1QgUm9vdCBDQSBYMzCCASIwDQYJKoZIhvcNAQEBBQAD
ggEPADCCAQoCggEBAN+v6ZdQCINXtMxiZfaQguzH0yxrMMpb7NnDfcdAwRgUi+DoM3ZJKuM/IUmT
rE4Orz5Iy2Xu/NMhD2XSKtkyj4zl93ewEnu1lcCJo6m67XMuegwGMoOifooUMM0RoOEqOLl5CjH9
UL2AZd+3UWODyOKIYepLYYHsUmu5ouJLGiifSKOeDNoJjj4XLh7dIN9bxiqKqy69cK3FCxolkHRy
xXtqqzTWMIn/5WgTe1QLyNau7Fqckh49ZLOMxt+/yUFw7BZy1SbsOFU5Q9D8/RhcQPGX69Wam40d
utolucbY38EVAjqr2m7xPi71XAicPNaDaeQQmxkqtilX4+U9m5/wAl0CAwEAAaNCMEAwDwYDVR0T
AQH/BAUwAwEB/zAOBgNVHQ8BAf8EBAMCAQYwHQYDVR0OBBYEFMSnsaR7LHH62+FLkHX/xBVghYkQ
MA0GCSqGSIb3DQEBBQUAA4IBAQCjGiybFwBcqR7uKGY3Or+Dxz9LwwmglSBd49lZRNI+DT69ikug
dB/OEIKcdBodfpga3csTS7MgROSR6cz8faXbauX+5v3gTt23ADq1cEmv8uXrAvHRAosZy5Q6XkjE
GB5YGV8eAlrwDPGxrancWYaLbumR9YbK+rlmM6pZW87ipxZzR8srzJmwN0jP41ZL9c8PDHIyh8bw
RLtTcm1D9SZImlJnt1ir/md2cXjbDaJWFBM5JDGFoqgCWjBH4d1QB7wCCZAA62RjYJsWvIjJEubS
fZGL+T0yjWW06XyxV3bqxbYoOb8VZRzI9neWagqNdwvYkQsEjgfbKbYK7p2CNTUQ
-----END CERTIFICATE-----
PEM_CERTIFICATE

CHEF_CA_CERT = '/opt/chef-workstation/embedded/ssl/certs/cacert.pem'

file "#{CHEF_CA_CERT}.orig" do
  content lazy { File.open(CHEF_CA_CERT).read }

  mode    '0755'

  action  :create_if_missing
  only_if { File.open(CHEF_CA_CERT).read.include?(DST_ROOT_CA_X3) }
end

file CHEF_CA_CERT do
  content lazy { File.open(CHEF_CA_CERT).read.split(DST_ROOT_CA_X3).join("(DST Root CA X3 was removed by Chef at #{Time.now})") }

  mode    '0755'

  action  :create
  only_if { File.open(CHEF_CA_CERT).read.include?(DST_ROOT_CA_X3) }
end
