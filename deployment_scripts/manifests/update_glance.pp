notice('MURANO PLUGIN: update_glance.pp')

$murano_hash    = hiera_hash('murano', {})
$murano_plugins = $murano_hash['plugins']

include ::glance::params

if has_key($murano_plugins, 'glance_artifacts_plugin') and $murano_plugins['glance_artifacts_plugin']['enabled'] {
  package {'murano-glance-artifacts-plugin':
    ensure  => installed,
  }

  glance_api_config {
    'DEFAULT/enable_v3_api': value => true,
  }
} else {
  glance_api_config {
    'DEFAULT/enable_v3_api': ensure => absent,
  }
}

if !defined(Service[$::glance::params::api_service_name]) {
  service { $::glance::params::api_service_name:
    ensure  => 'running',
    enable  => true,
    restart => true,
    tag     => 'glance-service',
  }
}

if !defined(Service[$::glance::params::registry_service_name]) {
  service { $::glance::params::registry_service_name:
    ensure  => 'running',
    enable  => true,
    restart => true,
    tag     => 'glance-service',
  }
}

Glance_Api_Config <||> ~> Service<| tag == 'glance-service' |>
