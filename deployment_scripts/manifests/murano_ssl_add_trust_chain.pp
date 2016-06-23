notice('MURANO PLUGIN: murano_ssl_add_trust_chain.pp')

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

exec { 'add_trust':
  command     => 'update-ca-certificates',
  path        => '/bin:/usr/bin:/sbin:/usr/sbin',
  refreshonly => true,
}
