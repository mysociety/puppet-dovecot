#
# @summary This module installs, configures and manages Dovecot.
#
# @param package_ensure Status of insalled packages.
# @param package_manage Whether to manage packages.
# @param packages List of packages to install.
# @param service_ensure Desired service status.
# @param service_manage Whether to manage the service.
# @param service_name Name of the service.
# @param config_dir Path of configuration directory.
# @param mail_privileged_group Override the `mail_privileged_group` setting.
# @param mmap_disable Override the `mmap_disable` setting.
# @param mail_fsync Override the `mail_fsync` setting.
# @param mail_location Override the `mail_location` setting.
# @param passdb Settings for `passdb` configuration. The subkeys used are sorted. Default: `passdb{pam}{driver} = pam`
# @param userdb Settings for `userdb` configuration.  The subkeys used are sorted. Default: `userdb{passwd}{driver} = passwd`
# @param ssl SSL status.
# @param ssl_cert Location of SSL cert. Default: `</etc/dovecot/dovecot.pem`
# @param ssl_key Location of SSL key.  Default: `</etc/dovecot/private/dovecot.pem`
# @param ssl_protocols SSL Protocol definitions. Deafult: `!SSLv2 !SSLv3`
# @param ssl_cipher_list SSL Ciphers Default: `ALL:!LOW:!SSLv2:!EXP:!aNULL`
#
# @example Deploy with defaults, including self-signed SSL certificate:
#  include dovecot
#
# @example Provide your own SSL certificates:
#  class { 'dovecot':
#    ssl_cert => '</etc/ssl/certs/mail.crt',
#    ssl_key  => '</etc/ssl/private/mail.key',
#  }
#
# @author mySociety https://www.mysociety.org/
# @see https://github.com/mysociety/puppet-dovecot
# @see https://wiki.dovecot.org/
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
  String $mail_location,
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
