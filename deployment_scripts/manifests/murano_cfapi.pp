notice('MURANO PLUGIN: murano_cfapi.pp')

prepare_network_config(hiera_hash('network_scheme', {}))

$access_hash       = hiera_hash('access', {})
$murano_cfapi_hash = hiera_hash('murano_cfapi', {})
$cfapi_enabled     = $murano_cfapi_hash['enabled']
$public_ip         = hiera('public_vip')
$management_ip     = hiera('management_vip')
$public_ssl_hash   = hiera_hash('public_ssl', {})
$ssl_hash          = hiera_hash('use_ssl', {})
$service_endpoint  = hiera('service_endpoint')
$external_lb       = hiera('external_lb', false)

$public_auth_protocol = get_ssl_property($ssl_hash, $public_ssl_hash, 'keystone', 'public', 'protocol', 'http')
$public_auth_address  = get_ssl_property($ssl_hash, $public_ssl_hash, 'keystone', 'public', 'hostname', [$public_ip])

$cfapi_bind_host = get_network_role_property('management', 'ipaddr')
$cfapi_bind_port = '8083'

$firewall_rule = '203 murano-cfapi'
include ::firewall
firewall { $firewall_rule :
  dport  => $cfapi_bind_port,
  proto  => 'tcp',
  action => 'accept',
}

####### Disable upstart startup on install #######
tweaks::ubuntu_service_override { ['murano-cfapi']:
  package_name => 'murano-cfapi',
}

class { '::murano::cfapi' :
  tenant    => $access_hash['tenant'],
  enabled   => $cfapi_enabled,
  bind_host => $cfapi_bind_host,
  bind_port => $cfapi_bind_port,
  auth_url  => "${public_auth_protocol}://${public_auth_address}:5000/",
}

if $cfapi_enabled {
  $haproxy_stats_url     = "http://${management_ip}:10000/;csv"
  $murano_cfapi_protocol = get_ssl_property($ssl_hash, {}, 'murano', 'internal', 'protocol', 'http')
  $murano_cfapi_address  = get_ssl_property($ssl_hash, {}, 'murano', 'internal', 'hostname', [$service_endpoint, $management_ip])
  $murano_cfapi_url      = "${murano_cfapi_protocol}://${murano_cfapi_address}:${cfapi_bind_port}"
  $lb_defaults           = { 'provider' => 'haproxy', 'url' => $haproxy_stats_url }

  if $external_lb {
    $lb_backend_provider = 'http'
    $lb_url = $murano_cfapi_url
  }

  $lb_hash = {
    'murano-cfapi' => {
      name     => 'murano-cfapi',
      provider => $lb_backend_provider,
      url      => $lb_url
    }
  }

  ::osnailyfacter::wait_for_backend {'murano-cfapi':
    lb_hash     => $lb_hash,
    lb_defaults => $lb_defaults
  }
  Service['murano-cfapi'] -> ::Osnailyfacter::Wait_for_backend['murano-cfapi']
}

Firewall[$firewall_rule] -> Class['murano::cfapi']
