# == Class: dovecot
#
# This module installs, configures and manages Dovecot.
#
# === Parameters
#
# [*mail_privileged_group*]
#   Group to enable temporarily for privileged operations.
#   Default: mail
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
# [*passdb*]
#   Hash containing passdb configuration. The subkeys used are sorted.
#   Default: passdb{pam}{driver} = pam.
#
# [*userdb*]
#   Hash containing userdb configuration. The subkeys used are sorted.
#   Default: userdb{passwd}{driver} = passwd.
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
  String $package_ensure,
  Boolean $package_manage,
  Array $packages,
  # service
  String $service_ensure,
  Boolean $service_manage,
  String $service_name,
  # config
  String $config_dir,
  String $mail_privileged_group,
  String $mmap_disable,
  String $mail_fsync,
  Hash $passdb,
  Hash $userdb,
  # SSL
  String $ssl,
  String $ssl_cert,
  String $ssl_key,
  String $ssl_protocols,
  String $ssl_cipher_list,
)
{

  contain dovecot::install
  contain dovecot::config
  contain dovecot::service

  Class['::dovecot::install']
  -> Class['::dovecot::config']
  ~> Class['::dovecot::service']

}
