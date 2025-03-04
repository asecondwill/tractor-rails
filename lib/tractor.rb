# frozen_string_literal: true

require_relative "tractor/version"

module Tractor
  class Error < StandardError; end
  # Your code goes here...
  class Engine < ::Rails::Engine
  end
end

