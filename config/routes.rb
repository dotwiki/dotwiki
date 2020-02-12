Rails.application.routes.draw do
  root "home#index"
  get "/thanks", to: "home#thanks"

  resources :wikis, except: [:destroy], param: :wiki_id do
    member do
      get "/about", to: "wikis#about"
      post "/upload", to: "wikis#upload"
      resource :nav, only: [:edit, :update], module: "wikis"
      resources :maintainers, except: %i[show new edit], module: "wikis"
      resources :attachments, except: %i[show], module: "wikis" do
        collection do
          get "/all", to: "attachments#all"
        end
      end
      resources :pages, except: [:destroy], module: "wikis", as: :wiki_pages do
        resources :requests do
          get "/adjust", to: "requests#adjust"
          post "/merge", to: "requests#merge"
          post "/reject", to: "requests#reject"
        end
      end
    end
  end

  resources :users, except: [:index] do
    resources :watches, only: [:update], module: "users", as: :watch_wiki, param: :wiki_id
    resources :notices, only: [:index, :destroy], module: "users"
    member do
      get :activate
      get :change_password
      get :delete
    end
  end

  post "oauth/callback", to: "oauths#callback"
  get "oauth/callback", to: "oauths#callback"
  get "oauth/callback/:provider", to: "oauths#callback"
  get "oauth/login_from/:provider", to: "oauths#oauth", as: :auth_at_provider
  get "login", to: "user_sessions#new", as: :login
  post "logout", to: "user_sessions#destroy", as: :logout
  resources :user_sessions, only: [:new, :create, :destroy]
  resources :password_resets, only: [:new, :create, :edit, :update]
end
