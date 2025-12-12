# frozen_string_literal: true
# lib/houston_cms.rb
require_relative "houston_cms/version"


module HoustonCms
  class Configuration
    attr_accessor :importmap
    
    def initialize
      @importmap = Importmap::Map.new
    end
  end
  
  class << self
    def config
      @config ||= Configuration.new
    end
  end
  
  require 'friendly_id'
  require 'simple_form'
  require 'name_of_person'
  require 'pagy'

  class Error < StandardError; end

  class Engine < ::Rails::Engine
     
    initializer "houston_cms.pagy" do
      # Pagy config will be loaded automatically from config/initializers/
    end
  
    config.sidebar_content_items = [{
      name: 'Snippets',
      icon: 'bi-ui-checks',
      path: '/admin/snippets'
    }]
     
    # Add the assets paths to the engine
    initializer "houston_cms.assets.paths" do |app|
      app.config.assets.paths << root.join("app", "assets", "stylesheets")
      # this does nothing right?  its all in the assets dir
      app.config.assets.paths << root.join("app", "javascript").to_s 
    end

    

    # Configure Dart Sass builds
    # initializer "houston_cms.assets.configure" do |app|
    #   # app.config.dartsass.builds = {
    #   #   "admin.scss" => "admin.css"
    #   # }
    #  # puts "Dart Sass builds: #{app.config.dartsass.builds.inspect}"
    # end

  

    # initializer "houston_cms.debug" do |app|
    #   #puts "Asset paths: #{app.config.assets.paths.inspect}"
    # end

    initializer "houston_cms.load_dependencies" do
      require "name_of_person"
      require "ransack"
      require "commonmarker"
      require "github-markup"
      require "acts_as_list"
      require "ancestry"
      require "shortcode"
      require "marksmith"
      require "breadcrumbs_on_rails"
      require_relative "houston_cms/bootstrap_five_breadcrumbs"
      # require "marksmith/marksmith_helper" # nope
    end

    # Load the routes from the gem
    initializer "houston_cms.load_app_instance_data" do |app|
      HoustonCms::Engine.routes.default_url_options = app.config.action_mailer.default_url_options
    end

    initializer "houston_cms.load_static_assets" do |app|
      app.middleware.use ::ActionDispatch::Static, "#{root}/public"
    end



 
    # initializer "houston_cms.helpers" do
    #   ActiveSupport.on_load(:action_view) do
    #     include Marksmith::MarksmithHelper
    #   end
    # end - nope



    config.after_initialize do
      Rails.application.routes.prepend do
        mount HoustonCms::Engine, at: "/admin"
      end
    end
  end
end

