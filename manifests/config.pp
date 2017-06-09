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

  # Jessie doesn't generate a self-signed certificate on install, wheezy does.
  # Our defaults assume this is present, so it's polite to create it.
  if $facts['os']['distro']['codename'] == 'jessie' {

    file { '/usr/share/dovecot/dovecot-openssl.cnf':
      content => template('dovecot/dovecot-openssl.cnf.erb'),
    }

    exec { 'generate_certs':
      cwd     => '/usr/share/dovecot',
      command => '/usr/share/dovecot/mkcert.sh',
      require => File['/usr/share/dovecot/dovecot-openssl.cnf'],
      creates => '/etc/dovecot/dovecot.pem',
    }

  }

}
