class dovecot::config inherits dovecot {

  File {
    ensure => 'present',
    owner  => 'root',
    group  => 'root',
    mode   => '0644',
  }

  # Primary configuration file
  file { "${dovecot::config_dir}/dovecot.conf":
    content => template('dovecot/dovecot.conf.erb'),
  }

  # Core settings file
  file { "${dovecot::config_dir}/conf.d/10-mail.conf":
    content => template('dovecot/10-mail.conf.erb'),
  }

  # Auth and User file
  file { "${dovecot::config_dir}/conf.d/10-auth.conf":
    content => template('dovecot/10-auth.conf.erb'),
  }

  # SSL
  file { "${dovecot::config_dir}/conf.d/10-ssl.conf":
    content => template('dovecot/10-ssl.conf.erb'),
  }

}
