class dovecot::service inherits dovecot {

  if $dovecot::service_manage {
    service { $dovecot::service_name:
      ensure => $dovecot::service_ensure,
    }
  }

}
