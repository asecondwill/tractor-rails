# frozen_string_literal: true
# lib/tractor.rb
require_relative "tractor/version"


module Tractor
  include ActiveSupport::Configurable
  config_accessor :importmap
  self.importmap = Importmap::Map.new

  class Error < StandardError; end

  class Engine < ::Rails::Engine
    config.sidebar_content_items = [{
      name: 'Snippets',
      icon: 'bi-ui-checks',
      path: '/admin/snippets'
    }]
     
    # Add the assets paths to the engine
    initializer "tractor.assets.paths" do |app|
      app.config.assets.paths << root.join("app", "assets", "stylesheets")
      # this does nothing right?  its all in the assets dir
      app.config.assets.paths << root.join("app", "javascript").to_s 
    end

    

    # Configure Dart Sass builds
    # initializer "tractor.assets.configure" do |app|
    #   # app.config.dartsass.builds = {
    #   #   "admin.scss" => "admin.css"
    #   # }
    #  # puts "Dart Sass builds: #{app.config.dartsass.builds.inspect}"
    # end

  

    # initializer "tractor.debug" do |app|
    #   #puts "Asset paths: #{app.config.assets.paths.inspect}"
    # end

    initializer "tractor.load_dependencies" do
      require "name_of_person"
      require "ransack"
      require "commonmarker"
      require "github-markup"
      require "acts_as_list"
      require "ancestry"
      require "shortcode"
      require "marksmith"
      # require "marksmith/marksmith_helper" # nope
    end

    # Load the routes from the gem
    initializer "tractor.load_app_instance_data" do |app|
      Tractor::Engine.routes.default_url_options = app.config.action_mailer.default_url_options
    end

    initializer "tractor.load_static_assets" do |app|
      app.middleware.use ::ActionDispatch::Static, "#{root}/public"
    end



 
    # initializer "tractor.helpers" do
    #   ActiveSupport.on_load(:action_view) do
    #     include Marksmith::MarksmithHelper
    #   end
    # end - nope



    config.after_initialize do
      Rails.application.routes.prepend do
        mount Tractor::Engine, at: "/admin"
      end
    end
  end
end

