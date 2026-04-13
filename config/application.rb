require_relative "boot"

require "rails/all"

Bundler.require(*Rails.groups)

module CfBombinhas
  class Application < Rails::Application
    config.load_defaults 8.1
    config.autoload_lib(ignore: %w[assets tasks templates])
    config.eager_load = false
    config.generators do |g|
      g.orm :active_record, primary_key_type: :uuid
    end
  end
end
