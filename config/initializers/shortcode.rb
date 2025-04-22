require "shortcode"
shortcode = Shortcode.new
shortcode.setup do |config|
  config.block_tags = [:quote]
  config.self_closing_tags = [:youtube]
end

class Shortcode::TemplateBinding
  include Rails.application.routes.url_helpers
end