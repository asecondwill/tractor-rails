Rails.application.routes.draw do
  namespace :admin do
    root 'site#dash'
    get 'dash', to: 'site#dash'
    get "settings", to: "users#settings"
    put "amend", to: "users#amend"

    resources :snippets
    resources :menus
    resources :pages        
    resources :users do
      post :impersonate, on: :member
    end
  end
end