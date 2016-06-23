notice('MURANO PLUGIN: murano_ssl_dns_setup.pp')

$public_ssl_hash = hiera_hash('public_ssl')
$ssl_hash = hiera_hash('use_ssl', {})
$public_vip = hiera('public_vip')
$management_vip = hiera('management_vip')

if !empty($ssl_hash) {
  $public_hostname     = try_get_value($ssl_hash, 'murano_public_hostname', undef)
  $internal_hostname   = try_get_value($ssl_hash, 'murano_internal_hostname', undef)
  $admin_hostname      = try_get_value($ssl_hash, 'murano_admin_hostname', $internal_hostname)
  $service_public_ip   = try_get_value($ssl_hash, "murano_public_ip", undef)
  $public_ip           = pick($service_public_ip, $public_vip)
  $service_internal_ip = try_get_value($ssl_hash, "murano_internal_ip", undef)
  $internal_ip         = pick($service_internal_ip, $management_vip)
  $service_admin_ip    = try_get_value($ssl_hash, "murano_admin_ip", undef)
  $admin_ip            = pick($service_admin_ip, $management_vip)

  # We always need to set public hostname resolution
  if $public_hostname {
    ensure_resource('host', $public_hostname, {
      name   => $public_hostname,
      ensure => present,
      ip     => $public_ip,
    })
  }
  if ($public_hostname == $internal_hostname) and ($public_hostname == $admin_hostname) {
    notify{"All Murano hostnames is equal, just public one inserted to DNS":}
  } elsif $public_hostanme == $internal_hostname {
    if $admin_hostname {
      ensure_resource('host', $admin_hostname, {
        name   => $admin_hostname,
        ensure => present,
        ip     => $admin_ip,
      })
    }
  } elsif ($public_hostname == $admin_hostname) or ($internal_hostname == $admin_hostname) {
    if $internal_hostname {
      ensure_resource('host', $internal_hostname, {
        name   => $internal_hostname,
        ensure => present,
        ip     => $internal_ip,
      })
    }
  } else {
    if $admin_hostname {
      ensure_resource('host', $admin_hostname, {
        name   => $admin_hostname,
        ensure => present,
        ip     => $admin_ip,
      })
    }
    if $internal_hostname {
      ensure_resource('host', $internal_hostname, {
        name   => $internal_hostname,
        ensure => present,
        ip     => $internal_ip,
      })
    }
  }
} elsif !empty($public_ssl_hash) {
  host { $public_ssl_hash['hostname']:
    ensure => present,
    ip     => $public_vip,
  }
}
