# == Class: dovecot
#
# This module installs, configures and manages Dovecot.
#
# === Parameters
#
# [*package_ensure*]
#   Status of insalled packages.
#   Default: installed
#
# [*package_manage*]
#   Whether to manage packages
#   Default: true
#
# [*packages*]
#   List of packages to install
#   Default: ['dovecot-pop3d']
#
# [*service_ensure*]
#   Desired service Status
#   Default: running
#
# [*service_manage*]
#   Whether to manage the service
#   Default: true
#
# [*service_name*]
#   Name of the service
#   Default: dovecot
#
# [*config_dir*]
#   Path of configuration directory
#   Deafult: /etc/dovecot
#
# [*ssl*]
#   SSL status
#   Default: required
#
# [*ssl_cert*]
#   Location of SSL cert
#   Default: </etc/dovecot/dovecot.pem
#
# [*ssl_key*]
#   Location of SSL key
#   Default: </etc/dovecot/private/dovecot.pem
#
# [*ssl_protocols*]
#   SSL Protocol definitions
#   Default: !SSLv2 !SSLv3
#
# [*ssl_cipher_list*]
#   SSL Ciphers
#   Default: ALL:!LOW:!SSLv2:!EXP:!aNULL
#
# === Examples
#
#  Deploy with defaults, including self-signed SSL certificate:
#
#  include dovecot
#
#  Provide your own SSL certificates:
#
#  class { 'dovecot':
#    ssl_cert => '</etc/ssl/certs/mail.crt',
#    ssl_key  => '</etc/ssl/private/mail.key',
#  }
#
# === Authors
#
# mySociety https://www.mysociety.org/
#
# === Copyright
#
# Copyright 2017 UK Citizens Online Democracy
#
class dovecot (
  # install
  $package_ensure      = 'installed',
  $package_manage      = true,
  $packages            = [ 'dovecot-pop3d' ],
  # service
  $service_ensure      = 'running',
  $service_manage      = true,
  $service_name        = 'dovecot',
  # config
  $config_dir          = '/etc/dovecot/',
  # SSL
  $ssl                 = 'required',
  $ssl_cert            = '</etc/dovecot/dovecot.pem',
  $ssl_key             = '</etc/dovecot/private/dovecot.pem',
  $ssl_protocols       = '!SSLv2 !SSLv3',
  $ssl_cipher_list     = 'ALL:!LOW:!SSLv2:!EXP:!aNULL',
)
{

  contain dovecot::install
  contain dovecot::config
  contain dovecot::service
  Class['::dovecot::install'] -> Class['::dovecot::config'] ~> Class['::dovecot::service']

}
