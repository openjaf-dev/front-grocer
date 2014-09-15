Rails.application.routes.draw do
  


  resources :companies

#  devise_for :admin_users, ActiveAdmin::Devise.config
#  ActiveAdmin.routes(self)
  
  root to: 'visitors#index'
  devise_for :users, :controllers => {:registrations => "registrations"}
  resources :users #, only: [:index]
  resources :user_steps
  resources :organizations
 
  devise_scope :user do
    #match '/users/sign_out' => 'sessions#destroy', via: [:get, :delete]
    get 'users/sign_out' => "devise/sessions#destroy"
  end
  
#  devise_scope :user do
#    authenticated :user do
#      root :to => 'visitors#index'
#    end
#    unauthenticated :user do
#      root :to => 'devise/registrations#new', as: :unauthenticated_root
#    end
#  end
  
  
  #resources :user_steps
  
  namespace :dashboard do
    get '/overview', to: 'overview#index', as: 'overview'
    
    namespace :sales do
      get 'product/by_categories',to: "product#by_categories"
      get 'product/by_brands',to: "product#by_brands"
      get 'product/by_value_categories',to: "product#by_value_categories"
      get 'product/by_value_brands',to: "product#by_value_brands"

      %w(sources revenues transactions items adjustments taxes shipments).each do |resource|
        get "/#{resource}", to: "#{resource}#index", as: "#{resource}"  
        
        %w(wday hour).each do |time_option|   
          get "/#{resource}/by-#{time_option}", to: "#{resource}#by_#{time_option}", as: "#{resource}_by_#{time_option}" 
        end
        
        get "/#{resource}/by-status", to: "#{resource}#by_status", as: "#{resource}_by_status"
        get "/#{resource}/by-sources", to: "#{resource}#by_sources", as: "#{resource}_by_sources"
      end  
    end
      
  end
end
