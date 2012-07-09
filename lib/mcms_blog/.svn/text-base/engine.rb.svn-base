module McmsBlog
  class Engine < ::Rails::Engine
  	require 'crudify'
    require 'friendly_id'
    require 'acts-as-taggable-on'

    config.autoload_paths += %W( #{config.root}/lib )
    config.autoload_paths += Dir["#{config.root}/lib/**/"]

    require 'yaml'
    YAML::ENGINE.yamler= 'syck'
  end
end
