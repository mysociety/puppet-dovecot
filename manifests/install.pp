class dovecot::install inherits dovecot {

  if $dovecot::package_manage {
    package { $dovecot::packages:
      ensure => $dovecot::package_ensure,
    }
  }

}
