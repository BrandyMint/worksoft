Worksoft::Application.routes.draw do
  get "user_sessions/new"
  get "user_sessions/create"
  get "user_sessions/destroy"

  ActiveAdmin.routes(self)

  namespace :developer do
    get :dashboard, :to => 'dashboard#show'
  end

  root :to => 'bundles#index'

  resources :user_sessions
  match 'login' => 'user_sessions#new', :as => :login
  match 'logout' => 'user_sessions#destroy', :as => :logout

  resources :users
  get "profile", :to => "users#profile"
    
  resources :bundles, :only => [:index, :show]
end
