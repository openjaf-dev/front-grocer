Rails.application.routes.draw do
  root to: 'visitors#index'
  devise_for :users
  resources :users
  
  namespace :dashboard do
    
    get '/overview', to: 'overview#index', as: 'overview'
    
    namespace :sales do
      ['sources','revenues','transactions','items','adjustments','taxes','shipments'].each do |resource|
        get "/#{resource}", to: "#{resource}#index", as: "#{resource}"   
        get "/#{resource}/by-week-days", to: "#{resource}#by_week_days", as: "#{resource}_by_week_days"
        get "/#{resource}/by-hours", to: "#{resource}#by_hours", as: "#{resource}_by_hours"    
      end  
    end
      
  end
end
