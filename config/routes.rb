Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  root to: 'visitors#index'
  get '/about', to: 'pages#about', as: 'about'
  get '/blank', to: 'pages#blank', as: 'blank'
  get '/profile', to: 'pages#profile', as: 'profile'
  get '/invoice', to: 'pages#invoice', as: 'invoice'
  get '/knowledgebase', to: 'pages#knowledgebase', as: 'knowledgebase'
  get '/inbox', to: 'pages#inbox', as: 'inbox'  
  get '/register', to: 'pages#register', as: 'register' 
  get '/login', to: 'pages#login', as: 'login'   
  get '/charts-d3charts', to: 'pages#charts-d3charts', as: 'charts-d3charts'
  get '/charts-statistics-interactive', to: 'pages#charts-statistics-interactive', as: 'charts-statistics-interactive'
  get '/charts-statistics', to: 'pages#charts-statistics', as: 'charts-statistics'
  get '/charts-statistics-real-time', to: 'pages#charts-statistics-real-time', as: 'charts-statistics-real-time'  
  get '/demo-dashboard', to: 'pages#demo-dashboard', as: 'demo-dashboard'
    
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
