require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module RescueRails
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.
    config.active_job.queue_adapter = :delayed_job

    config.active_record.time_zone_aware_types = [:datetime, :time]

    config.time_zone = 'Eastern Time (US & Canada)'

    # Resolves InvalidAuthenticityToken errors in Mobile Safari and Mobile Chrome
    # https://github.com/rails/rails/issues/21948#issuecomment-163995796
    config.action_dispatch.default_headers.merge!('Cache-Control' => 'no-store, no-cache')

    # after creating the dogs/ namespace to hold manager and gallery controllers, this becomes necessary
    config.action_view.prefix_partial_path_with_controller_namespace = false

    # we have a custom file in support of the faker gem
    I18n.load_path += Dir[ Rails.root.join("lib","locales","**/*.yml").to_s ]
  end
end
