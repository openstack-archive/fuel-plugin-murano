notice('MURANO PLUGIN: import_murano_package.pp')

$murano_hash = hiera_hash('murano', {})

if (roles_include(['primary-controller', 'controller']) and ! $murano_hash['murano_standalone']) or
   roles_include(['primary-murano-node', 'murano-node']) {
  murano::application { 'io.murano' : }
}
