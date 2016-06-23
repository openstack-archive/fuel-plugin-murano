notice('MURANO PLUGIN: logging_murano.pp')

$murano_hash = hiera_hash('murano')

if ! $murano_hash['murano_base'] or roles_include(['primary-murano-node', 'murano-node']) {

  $content=':syslogtag, contains, "murano" -/var/log/murano-all.log
  ### stop further processing for the matched entries
  & ~'

  include ::rsyslog::params

  ::rsyslog::snippet { '55-murano':
    content => $content,
  }

  Rsyslog::Snippet['55-murano'] ~> Service[$::rsyslog::params::service_name]

}
