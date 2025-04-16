Tractor.config.importmap.draw do
  # Stimulus & Turbo
  pin "@hotwired/stimulus", to: "stimulus.js"
  pin "@hotwired/stimulus-loading", to: "stimulus-loading.js"
  pin "@hotwired/turbo-rails", to: "turbo.js"

  # Tractor entrypoint
  pin "application", to: "tractor/application.js"
  pin "sortablejs", to: "tractor/libraries/sortable.js"
  
  pin_all_from Tractor::Engine.root.join("app/assets/javascripts/tractor/controllers"), under: "controllers", to: "tractor/controllers"
  #pin_all_from Tractor::Engine.root.join("app/assets/javascripts/tractor/libraries"), under: "libraries", to: "tractor/libraries"
end

Tractor.config.importmap.cache_sweeper watches: Tractor::Engine.root.join("app/assets/javascripts")

ActiveSupport.on_load(:action_controller_base) do
  before_action { Tractor.config.importmap.cache_sweeper.execute_if_updated }
end