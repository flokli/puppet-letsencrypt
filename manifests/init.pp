class letsencrypt (
  String $interval = 'weekly',
) inherits letsencrypt::params {
  $package_name = $letsencrypt::params::package_name

  package { $package_name:
    ensure => latest,
  }

  file { '/etc/systemd/system/letsencrypt.service':
    ensure  => file,
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    content => epp('letsencrypt/letsencrypt.service.epp', {
      'package_name' => $package_name,
    }),
  }
  file { '/etc/systemd/system/letsencrypt.service.d':
    ensure => directory,
    owner  => 'root',
    group  => 'root',
    mode   => '0644',
  }
  file { '/etc/systemd/system/letsencrypt.timer':
    ensure  => file,
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    content => epp('letsencrypt/letsencrypt.timer.epp', {
      'interval' => $interval
    }),
  }
  service { 'letsencrypt.timer':
    ensure => running,
    enable => true,
  }
}
