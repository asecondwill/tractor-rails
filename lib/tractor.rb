# frozen_string_literal: true

require_relative "tractor/version"


module Tractor
  class Error < StandardError; end

  class Engine < ::Rails::Engine
    # Add the assets paths to the engine
    initializer "tractor.assets.paths" do |app|
      app.config.assets.paths << root.join("app", "assets", "stylesheets")
    end

    # Configure Dart Sass builds
    initializer "tractor.assets.configure" do |app|
      # app.config.dartsass.builds = {
      #   "admin.scss" => "admin.css"
      # }
      puts "Dart Sass builds: #{app.config.dartsass.builds.inspect}"
    end

    initializer "tractor.debug" do |app|
      puts "Asset paths: #{app.config.assets.paths.inspect}"
    end

    initializer "your_gem_name.load_dependencies" do
      require "name_of_person"
      require "ransack"
      require "commonmarker"
      require "github-markup"
    end

    # Load the routes from the gem
    initializer "tractor.load_app_instance_data" do |app|
      Tractor::Engine.routes.default_url_options = app.config.action_mailer.default_url_options
    end

    initializer "tractor.load_static_assets" do |app|
      app.middleware.use ::ActionDispatch::Static, "#{root}/public"
    end

    config.after_initialize do
      Rails.application.routes.prepend do
        mount Tractor::Engine, at: "/admin"
      end
    end
  end
end

