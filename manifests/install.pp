#
# @summary Internal class to install Dovecot
#
class dovecot::install inherits dovecot {

  if $dovecot::package_manage {
    ensure_packages($dovecot::packages, { ensure => $dovecot::package_ensure })
  }

}
