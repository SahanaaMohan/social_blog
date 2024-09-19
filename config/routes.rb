require 'sidekiq/web'
require 'sidekiq-scheduler/web'

Rails.application.routes.draw do
scope "(:locale)", locale: /#{I18n.available_locales.join("|")}/ do

  resources :lists
  resources :companies
  
  devise_for :admins, path: 'admins', controllers: {
    sessions: 'admins/sessions',
    registrations: 'admins/registrations'
  }

  devise_scope :user do
    authenticated :user do
      namespace :users do
        get 'admins/dashboard/index', as: :authenticated_root
        resources :recommended_posts, only: [:index]
      end
    end
  end

  devise_scope :admin do
    authenticated :admin do
      namespace :admins do
        get '', to: 'dashboard#index', as: '/'
      end
    end
  end
  match '/blog_posts/view',   to: 'blog_posts#view',   via: 'get'
  get 'users/index'
  get "/blog_posts/scheduled", to:"blog_posts#scheduled"
  devise_for :views
  devise_for :users, :path_prefix => 'd'
    resources :blog_posts, except: [:index] do
      namespace :openai do
        resources :blog_posts, only: [:create, :update, :edit]
    end
      resources :responses, only: [:create] do
        namespace :openai do
         resources :responses, only: [:create]
      end
    end
  end

resources :blog_posts do
      resource :cover_image, only: [:destroy], module: :blog_posts
      resource :likes, module: :blog_posts
      resource :bookmarks, module: :blog_posts
end
    resources :users, :only =>[:show]
  
root "blog_posts#index"
  post    "interests" => "interests#create"
  delete  "interests" => "interests#destroy"
  match '/users',   to: 'users#index',   via: 'get'
  match '/users/:id',     to: 'users#show',       via: 'get'
  match '/blog_posts/:blog_post_id/openai/blog_posts/:id/edit',to: 'openai/blog_posts#edit',via: 'put'
  resources :relationships, only: [:create, :destroy]
  # Mount Sidekiq web interface at a specific route
   mount Sidekiq::Web => '/sidekiq'
   mount ActionCable.server => '/cable'
   mount Notifications::Engine => "/notifications"
   get "search" => "search#search", as: :search
   resources :tags
   resources :companies
    resource :dashboard, only: [:show]
   resources :interests
   resources :rooms do
    resource :room_users
    resources :messages
    resources :following_tags, only: [:index]
  end
end
end
