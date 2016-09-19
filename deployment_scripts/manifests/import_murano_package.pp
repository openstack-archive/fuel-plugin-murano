notice('MURANO PLUGIN: import_murano_package.pp')

murano::application { 'io.murano-old' :
  package_ensure => absent,
  package_name   => 'io.murano',
} ->
murano::application { 'io.murano' : }
murano::application { 'io.murano.applications' : }
