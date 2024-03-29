require_relative "boot"

require "rails/all"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module AlignFitness
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 7.0

    # Configuration for the application, engines, and railties goes here.
    #
    # These settings can be overridden in specific environments using the files
    # in config/environments, which are processed later.
    #
    # config.time_zone = "Central Time (US & Canada)"
    # config.eager_load_paths << Rails.root.join("extras")

    #to skip assets, scaffolds.css, test framework, helpers, view
    config.generators do |g|
      g.test_framework  nil #to skip test framework
      g.assets  false
      g.helper false
      g.stylesheets false
    end

    config.to_prepare do
      # configure devise mailer layout
      Devise::Mailer.layout "mailer"
    end

    # Default url for sending emails
    config.action_mailer.default_url_options = { host: ENV['DOMAIN'] }
    config.action_mailer.asset_host = "#{Rails.env == 'production' ? 'https://' : 'http://'}#{ENV['DOMAIN']}"
    # Implement sidekiq for background jobs
    config.active_job.queue_adapter = :sidekiq
    # default timezone to australia
    config.time_zone = 'Australia/Sydney'
    # Use own routes for exceptions
    config.exceptions_app = self.routes
  end
end
