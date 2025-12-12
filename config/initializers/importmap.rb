HoustonCms.config.importmap.draw do
  # Stimulus & Turbo
  pin "@hotwired/stimulus", to: "stimulus.js"
  pin "@hotwired/stimulus-loading", to: "stimulus-loading.js"
  pin "@hotwired/turbo-rails", to: "turbo.js"

  # HoustonCms entrypoint
  pin "application", to: "houston_cms/application.js"
  pin "sortablejs", to: "houston_cms/libraries/sortable.js"
  pin "@avo-hq/marksmith", to: "https://ga.jspm.io/npm:@avo-hq/marksmith@0.4.0/dist/marksmith.esm.js"
  pin_all_from HoustonCms::Engine.root.join("app/assets/javascripts/houston_cms/controllers"), under: "controllers", to: "houston_cms/controllers"
  #pin_all_from HoustonCms::Engine.root.join("app/assets/javascripts/houston_cms/libraries"), under: "libraries", to: "houston_cms/libraries"
  
  # pin 'popper', to: 'popper.js'
  
  pin "@popperjs/core", to: "https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.8/dist/esm/popper.js"
  pin "bootstrap", to: "https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.esm.min.js"
  
end

HoustonCms.config.importmap.cache_sweeper watches: HoustonCms::Engine.root.join("app/assets/javascripts")

ActiveSupport.on_load(:action_controller_base) do
  before_action { HoustonCms.config.importmap.cache_sweeper.execute_if_updated }
end