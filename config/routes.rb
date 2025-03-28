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
    resources :pages
    resources :sections do
      member  do
        patch :move
      end
    end
    # menus
    get "links/menuitems", to: "links#menuitems"
    resources :menus do
      resources :menuitems do
        member do
          patch :move
        end
      end
    end
    get "links/menuitems", to: "links#menuitems"
    resources :menus do
      resources :menuitems do
        member do
          patch :move
        end
      end
    end
  end
end