class letsencrypt::params {
  case $::osfamily {
    'archlinux': {
      $webroot = '/srv/http'
    }
    'debian': {
      $webroot = '/var/www/html'
    }
    default: {
      fail("no support for {$::osfamily}. please add support!")
    }
  }
}

class letsencrypt {
  include letsencrypt::params

  package { 'certbot':
    ensure => latest,
  }

  file { '/etc/systemd/system/certbot.service':
    ensure => file,
    owner => 'root',
    group => 'root',
    mode => '0644',
    source => 'puppet:///modules/letsencrypt/certbot.service',
  }
  file { '/etc/systemd/system/certbot.service.d':
    ensure => directory,
    owner => 'root',
    group => 'root',
    mode => '0644',
  }
  file { '/etc/systemd/system/certbot.timer':
    ensure => file,
    owner => 'root',
    group => 'root',
    mode => '0644',
    source => 'puppet:///modules/letsencrypt/certbot.timer',
  }
  service { 'certbot.timer':
    ensure => running,
    enable => true,
  }
}
