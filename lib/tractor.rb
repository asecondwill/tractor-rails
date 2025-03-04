# frozen_string_literal: true

require_relative "tractor/version"

module Tractor
  class Error < StandardError; end
  # Your code goes here...
  class Engine < ::Rails::Engine
    initializer "tractor.assets.precompile" do |app|
      app.config.assets.precompile += %w[admin_helpers.scss]
    end
  end
end

