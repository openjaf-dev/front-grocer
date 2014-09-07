Rails.application.routes.draw do
  


  resources :companies

#  devise_for :admin_users, ActiveAdmin::Devise.config
#  ActiveAdmin.routes(self)
  
  root to: 'visitors#index'
  devise_for :users
  resources :users
 
  
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

      ['sources','revenues','transactions','items','adjustments','taxes','shipments'].each do |resource|
        get "/#{resource}", to: "#{resource}#index", as: "#{resource}"   
        get "/#{resource}/by-week-days", to: "#{resource}#by_week_days", as: "#{resource}_by_week_days"
        get "/#{resource}/by-hours", to: "#{resource}#by_hours", as: "#{resource}_by_hours"
        get "/#{resource}/by-status", to: "#{resource}#by_status", as: "#{resource}_by_status"
        get "/#{resource}/by-sources", to: "#{resource}#by_sources", as: "#{resource}_by_sources"
      end  
    end
      
  end
end
