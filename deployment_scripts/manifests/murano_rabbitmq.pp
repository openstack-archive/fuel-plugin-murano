notice('MODULAR: murano_rabbitmq.pp')

$rabbit_hash = hiera_hash('rabbit', {})
$murano_hash = hiera_hash('murano', {})

if (roles_include(['primary-controller', 'controller']) and ! $murano_hash['murano_standalone']) or
    roles_include(['primary-murano-node', 'murano-node']) {

  if $rabbit_hash == {} {
    fail('No rabbit_hash defined')
  }
  if !$rabbit_hash['password'] {
    fail('Rabbit password is not set')
  }

  $rabbit_user          = pick($rabbit_hash['user'], 'nova')
  $rabbit_password      = $rabbit_hash['password']
  $rabbit_vhost         = $murano_hash['rabbit']['vhost']
  $rabbit_node_name     = 'murano@localhost'
  $rabbit_service_name  = 'murano-rabbitmq'

  #################################################################

  package { 'murano-rabbitmq':
    ensure => latest,
  }

  $firewall_rule = '203 murano-rabbitmq'
  include ::firewall
  firewall { $firewall_rule :
    dport  => '55572',
    proto  => 'tcp',
    action => 'accept',
    before => Service[$rabbit_service_name],
  }

  service { $rabbit_service_name :
    ensure => 'running',
    name   => $rabbit_service_name,
    enable => true,
  }

  exec { 'remove_murano_guest' :
    command => "rabbitmqctl -n '${rabbit_node_name}' delete_user guest",
    onlyif  => "rabbitmqctl -n '${rabbit_node_name}' list_users | grep -qE '^guest\\s*\\['",
    path    => [ '/bin', '/sbin', '/usr/bin', '/usr/sbin' ],
  }

  exec { 'create_murano_user' :
    command => "rabbitmqctl -n '${rabbit_node_name}' add_user '${rabbit_user}' '${rabbit_password}'",
    unless  => "rabbitmqctl -n '${rabbit_node_name}' list_users | grep -qE '^${rabbit_user}\\s*\\['",
    path    => [ '/bin', '/sbin', '/usr/bin', '/usr/sbin' ],
  }

  exec { 'create_murano_vhost' :
    command => "rabbitmqctl -n '${rabbit_node_name}' add_vhost '${rabbit_vhost}'",
    unless  => "rabbitmqctl -n '${rabbit_node_name}' list_vhosts | grep -qE '^${rabbit_vhost}$'",
    path    => [ '/bin', '/sbin', '/usr/bin', '/usr/sbin' ],
  }

  exec { 'set_murano_user_permissions' :
    command => "rabbitmqctl -n '${rabbit_node_name}' set_permissions -p '${rabbit_vhost}' '${rabbit_user}' '.*' '.*' '.*'",
    unless  => "rabbitmqctl -n '${rabbit_node_name}' list_user_permissions '${rabbit_user}' | grep -qE '^${rabbit_vhost}\\s*\\.\\*\\s*\\.\\*\\s*\\.\\*$'",
    path    => [ '/bin', '/sbin', '/usr/bin', '/usr/sbin' ],
  }

  Package['murano-rabbitmq'] ~> Service[$rabbit_service_name]
  Service[$rabbit_service_name] -> Exec<||>
}
