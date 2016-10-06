notice('MURANO PLUGIN: murano_disable_old.pp')
include ::murano::params

service { 'murano-rabbitmq':
  ensure => 'stopped',
}

service { 'murano-api':
  ensure => 'stopped',
  name   => $::murano::params::api_service_name
}

service { 'murano-engine':
  ensure => 'stopped',
  name   => $::murano::params::engine_service_name
}

$base_cfapi   = hiera_hash('murano-cfapi', {})
$plugin_cfapi = hiera_hash('murano_cfapi_plugin', {})
if pick($base_cfapi['enabled'], false) or pick($plugin_cfapi['enabled'], false) {
  service { 'murano-cfapi':
    ensure => 'stopped',
    name   => $::murano::params::cfapi_service_name
  }
}
