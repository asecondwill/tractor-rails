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
    
    resources :medias do
      collection do
        get "attach", to: "medias#attach"
      end
    end

    #get "attach-media", to: "media_library#attach"
    post "/rails/active_storage/direct_uploads", to: "/active_storage/direct_uploads#create"
    
  end
end