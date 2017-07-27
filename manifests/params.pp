class letsencrypt::params {
  case $::osfamily {
    'archlinux': {
      $webroot = '/srv/http'
    }
    'debian': {
      $webroot = '/var/www/html'
      $distcodename = $::facts['os']['lsb']['distcodename']
      case $distcodename {
        'xenial': {
          $package_name = 'letsencrypt'
        }
        'stretch', 'jessie': {
          $package_name = 'certbot'
        }
        default: {
          fail("no support for ${package_name}, please add support")
        }
      }
    }
    default: {
      fail("no support for {${::osfamily}}. please add support!")
    }
  }
}
