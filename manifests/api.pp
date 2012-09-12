#
class cinder::api (
  $package_ensure = 'latest',
  $enabled        = true
) {

  include cinder::params

  package { 'cinder-api':
    name    => $::cinder::params::api_package,
    ensure  => $package_ensure,
    require => Class['cinder'],
  }

  if $enabled {
    $ensure = 'running'
  } else {
    $ensure = 'stopped'
  }

  service { 'cinder-api':
    name      => $::cinder::params::api_service,
    enable    => $enabled,
    ensure    => $ensure,
    require   => Package[$::cinder::params::api_package],
  }

  Ini_setting<| tag == $::cinder::params::cinder_conf_tag |> ~> Service['cinder-api']
}
