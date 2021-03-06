Worksoft::Application.routes.draw do
  self.default_url_options Settings.default_url_options.to_hash

  ActiveAdmin.routes(self)

  root :to => 'apps#index'

  namespace :developer do
    get :dashboard, :to => 'dashboard#show'
    get :show_headers, :to => 'dashboard#show_headers'
    resource :profile, :controller => :profile, :only => [:new, :create, :edit, :update]
    resources :apps do
      resources :bundles do 
        member do
          get :restore
        end
      end
    end
  end

  resources :developers, :only => [:index, :show]

  resources :user_sessions
  resources :user_systems, :only => [:create, :new, :edit, :update]
  resources :password_resets

  match 'login' => 'user_sessions#new', :as => :login
  match 'logout' => 'user_sessions#destroy', :as => :logout
  match 'users/activate/:token' => 'users#activate', :as => :activate_user
  match 'users/resend_activation' => 'users#resend_activation', :as => :resend_activation

  resources :users, :only => [:new, :create, :update]

  get "profile", :to => "users#profile"
  get "profile/edit", :to => "users#edit_profile", :as => :user_edit_profile
  put "profile/update_password", :to => "users#update_password", :as => :user_update_password

  resources :apps, :only => [:index, :show] do
    collection do 
      get :search
    end
  end
end
