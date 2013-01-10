Worksoft::Application.routes.draw do
  ActiveAdmin.routes(self)

  root :to => 'apps#index'

  namespace :developer do
    get :dashboard, :to => 'dashboard#show'
    resource :profile, :controller => :profile, :only => [:new, :create, :edit, :update]
    resources :apps do
      resources :bundles
    end
  end

  resources :developers, :only => [:index, :show]

  resources :user_sessions
  match 'login' => 'user_sessions#new', :as => :login
  match 'logout' => 'user_sessions#destroy', :as => :logout

  resources :users, :only => [:new, :create]
  get "profile", :to => "users#profile"

  resources :apps, :only => [:index, :show]
    
  # resources :bundles, :only => [:index, :show]
end