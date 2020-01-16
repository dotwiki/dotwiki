Rails.application.routes.draw do
  root 'home#index'

  resources :wikis, except: [:destroy], param: :wiki_id do
    member do
      post '/upload', to: 'wikis#upload'
      resource :nav, only: [:edit, :update], module: "wikis"
      resources :maintainers, only: [:index, :update, :destroy], module: "wikis"
      resources :pages, except: [:destroy], module: "wikis", as: :wiki_pages
    end
  end

  resources :users, except: [:index] do
    resources :watches, only: [:update], module: "users", as: :watch_wiki, param: :wiki_id
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
  get 'login', to: 'user_sessions#new', as: :login
  post 'logout', to: 'user_sessions#destroy', as: :logout
  resources :user_sessions, only: [:new, :create, :destroy]
  resources :password_resets, only: [:new, :create, :edit, :update]

  # if Rails.env.development?
  #   mount LetterOpenerWeb::Engine, at: "/letter_opener"
  # end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
