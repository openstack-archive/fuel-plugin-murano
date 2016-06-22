notice('MURANO PLUGIN: pin_murano_plugin_repo.pp')

# Murano plugin repo doesn't have originator, release
$pins =  { "detach-murano-1.0.0" =>
              {
                 "priority" => 1200,
                 "label"    => "murano-plugin",
              },
          }

if ! empty($pins) {
  create_resources(apt::pin, $pins)
}
