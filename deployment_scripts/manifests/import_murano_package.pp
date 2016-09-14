notice('MURANO PLUGIN: import_murano_package.pp')

murano::application { 'io.murano' : }
murano::application { 'io.murano.application' : }
