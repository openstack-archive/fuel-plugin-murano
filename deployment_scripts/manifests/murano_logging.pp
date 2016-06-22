notice('MURANO PLUGIN: logging-murano.pp')

$murano_hash = hiera_hash('murano')

if ! $murano_hash['murano_base'] or roles_include(['primary-murano-node', 'murano-node']) {

  $content=':syslogtag, contains, "murano" -/var/log/murano-all.log\n
  ### stop further processing for the matched entries\n
  & ~'

  include ::rsyslog::params

  ::rsyslog::snippet { '55-murano':
    content => $content,
  }

  Rsyslog::Snippet['55-murano'] ~> Service[$::rsyslog::params::service_name]

}
