class letsencrypt::params {
  case $::osfamily {
    'archlinux': {
      $webroot = '/srv/http'
    }
    'debian': {
      $webroot = '/var/www/html'
    }
    default: {
      fail("no support for {${::osfamily}}. please add support!")
    }
  }
}
