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
  end
end

