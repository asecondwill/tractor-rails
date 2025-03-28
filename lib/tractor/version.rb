# frozen_string_literal: true

require_relative "tractor/menus/version"

module Tractor
  module Menus
    class Error < StandardError; end
    
    class Engine < ::Rails::Engine
      isolate_namespace Tractor::Menus
      
      # Add the assets paths to the engine
      initializer "tractor-menus.assets.paths" do |app|
        app.config.assets.paths << root.join("app", "assets", "stylesheets")
      end

      # Configure Dart Sass builds if needed
      initializer "tractor-menus.assets.configure" do |app|
        # Add any Dart Sass configuration here if needed
      end
      
      # Load and run migrations from the gem
      initializer :append_migrations do |app|
        unless app.root.to_s.match(root.to_s)
          config.paths["db/migrate"].expanded.each do |expanded_path|
            app.config.paths["db/migrate"] << expanded_path
          end
        end
      end
    end
  end
end