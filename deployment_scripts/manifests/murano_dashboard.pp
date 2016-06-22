notice('MURANO PLUGIN: murano_dashboard.pp')

$murano_hash    = hiera_hash('murano', {})
$murano_plugins = $murano_hash['plugins']
$repository_url = has_key($murano_hash, 'murano_repo_url') ? {
  true    => $murano_hash['murano_repo_url'],
  default => 'http://storage.apps.openstack.org',
}
if has_key($murano_plugins, 'glance_artifacts_plugin') and $murano_plugins['glance_artifacts_plugin']['enabled'] {
  $use_glare = true
  package {'murano-glance-artifacts-plugin':
    ensure  => 'latest',
  }
} else {
  $use_glare = false
}

include ::murano::params
include ::murano::client
include ::horizon::params

ensure_resource('service', 'httpd', {
  'ensure'  => 'running',
  'enable'  => true,
  'restart' => true,
  'name'    => $::horizon::params::http_service,
})

class { '::murano::dashboard':
  enable_glare   => $use_glare,
  repo_url       => $repository_url,
  sync_db        => false,
  package_ensure => 'latest'
}

Concat<||> ~> Service['httpd']
