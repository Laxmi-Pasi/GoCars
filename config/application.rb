require_relative "boot"

require "rails/all"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module ZoomCars
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 7.0
    if ['development', 'test'].include? ENV['RAILS_ENV']
      Dotenv::Railtie.load
    end
    config.active_storage.replace_on_assign_to_many = false
    # Configuration for the application, engines, and railties goes here.
    # These settings can be overridden in specific environments using the files
    # in config/environments, which are processed later.
    #
    # config.time_zone = "Central Time (US & Canada)"
    # config.eager_load_paths << Rails.root.join("extras")
    
    # to load models>psps files
    config.autoload_paths += Dir[Rails.root.join('app', 'models', '{**}')]
  end
end
