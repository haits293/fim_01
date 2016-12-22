Rails.application.routes.draw do
  post "/rate": "rater#create", as: "rate"
  devise_for :users, controllers: {omniauth_callbacks: :"callbacks#create"}
  root "static_pages#show", page: "home"

  get "static_pages/*page", to: "static_pages#show"

  namespace :admin do
    resources :users, only: [:index, :destroy]
    resources :artists, except: :show
    resources :categories, except: :show
    resources :albums, except: :show
  end

  resources :users, only: :show do
    member do
      resources :albums, only: [:new, :create]
    end
  end
  resources :relationships, only: [:index, :create, :destroy]
  resources :songs, only: :show do
    resources :comments
    get "/comments/new/(:parent_id)", to: "comments#new", as: :new_comment
  end
  resources :albums, only: :show do
    resources :comments
    get "/comments/new/(:parent_id)", to: "comments#new", as: :new_comment
  end
end
