notice('MURANO PLUGIN: logging-murano.pp')

$content=':syslogtag, contains, "murano" -/var/log/murano-all.log\n
### stop further processing for the matched entries\n
& ~'

include ::rsyslog::params

::rsyslog::snippet { '55-murano':
  content => $content,
}

Rsyslog::Snippet['55-murano'] ~> Service[$::rsyslog::params::service_name]
