notice('MURANO PLUGIN: murano_ssl_add_trust_chain.pp')

$murano_hash = hiera_hash('murano', {})

if (roles_include(['primary-controller', 'controller']) and ! $murano_hash['murano_standalone']) or
   roles_include(['primary-murano-node', 'murano-node']) {

  $public_ssl_hash = hiera_hash('public_ssl')
  $ssl_hash        = hiera_hash('use_ssl', {})

  File {
    ensure => file,
    notify => Exec['add_trust'],
  }

  if !empty($ssl_hash) {
    if !empty(file("/etc/pki/tls/certs/public_murano.pem",'/dev/null')) {
      file { "/usr/local/share/ca-certificates/murano_public_haproxy.crt":
        source => "/etc/pki/tls/certs/public_murano.pem",
      }
    }

    if !empty(file("/etc/pki/tls/certs/internal_murano.pem",'/dev/null')) {
      file { "/usr/local/share/ca-certificates/murano_internal_haproxy.crt":
        source => "/etc/pki/tls/certs/internal_murano.pem",
      }
    }

    if !empty(file("/etc/pki/tls/certs/admin_murano.pem",'/dev/null')) {
      file { "/usr/local/share/ca-certificates/murano_admin_haproxy.crt":
        source => "/etc/pki/tls/certs/admin_murano.pem",
      }
    }
  } elsif !empty($public_ssl_hash) {
      file { '/usr/local/share/ca-certificates/public_haproxy.crt':
        source => '/etc/pki/tls/certs/public_haproxy.pem',
      }
    }
  }

  exec { 'add_trust':
    command     => 'update-ca-certificates',
    path        => '/bin:/usr/bin:/sbin:/usr/sbin',
    refreshonly => true,
  }
}
