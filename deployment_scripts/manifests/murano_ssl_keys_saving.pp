notice('MURANO PLUGIN: murano_ssl_keys_saving.pp')

$murano_hash = hiera_hash('murano', {})

if (roles_include(['primary-controller', 'controller']) and ! $murano_hash['murano_standalone']) or
   roles_include(['primary-murano-node', 'murano-node']) {

  $public_ssl_hash = hiera_hash('public_ssl')
  $ssl_hash = hiera_hash('use_ssl', {})
  $pub_certificate_content = try_get_value($public_ssl_hash, 'cert_data/content', '')
  $base_path = '/etc/pki/tls/certs'
  $pki_path = [ '/etc/pki', '/etc/pki/tls' ]
  $astute_base_path = '/var/lib/astute/haproxy'

  File {
    owner => 'root',
    group => 'root',
    mode  => '0644',
  }

  file { [ $pki_path, $base_path, $astute_base_path ]:
    ensure => directory,
  }

  if !empty($ssl_hash) {
    $public_service = try_get_value($ssl_hash, "${service}_public", false)
    $public_usercert = try_get_value($ssl_hash, "${service}_public_usercert", false)
    $public_certdata = try_get_value($ssl_hash, "${service}_public_certdata/content", '')
    $internal_service = try_get_value($ssl_hash, "${service}_internal", false)
    $internal_usercert = try_get_value($ssl_hash, "${service}_internal_usercert", false)
    $internal_certdata = try_get_value($ssl_hash, "${service}_internal_certdata/content", '')
    $admin_service = try_get_value($ssl_hash, "${service}_admin", false)
    $admin_usercert = try_get_value($ssl_hash, "${service}_admin_usercert", false)
    $admin_certdata = try_get_value($ssl_hash, "${service}_admin_certdata/content", '')

    if $ssl_hash['murano'] {
      if $public_service and $public_usercert and !empty($public_certdata) {
        file { ["${base_path}/public_murano.pem", "${astute_base_path}/public_murano.pem"]:
          ensure  => present,
          content => $public_certdata,
        }
      }
      if $internal_service and $internal_usercert and !empty($internal_certdata) {
        file { ["${base_path}/internal_murano.pem", "${astute_base_path}/internal_murano.pem"]:
          ensure  => present,
          content => $internal_certdata,
        }
      }
      if $admin_service and $admin_usercert and !empty($admin_certdata) {
        file { ["${base_path}/admin_murano.pem", "${astute_base_path}/admin_murano.pem"]:
          ensure  => present,
          content => $admin_certdata,
        }
      }
    }
  } elsif !empty($public_ssl_hash) {
    file { ["${base_path}/public_haproxy.pem", "${astute_base_path}/public_haproxy.pem"]:
      ensure  => present,
      content => $pub_certificate_content,
    }
  }
}
