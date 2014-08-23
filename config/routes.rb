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
  get '/form-inplace-editing', to: 'pages#form-inplace-editing', as: 'form-inplace-editing'
  get '/form-elements', to: 'pages#form-elements', as: 'form-elements'
  get '/form-layouts', to: 'pages#form-layouts', as: 'form-layouts'
  get '/form-bootstrap-elements', to: 'pages#form-bootstrap-elements', as: 'form-bootstrap-elements'
  get '/form-validations', to: 'pages#form-validations', as: 'form-validations'
  get '/form-file-upload', to: 'pages#form-file-upload', as: 'form-file-upload'
  get '/form-text-editor', to: 'pages#form-text-editor', as: 'form-text-editor'
  get '/ui-elements-general', to: 'pages#ui-elements-general', as: 'ui-elements-general'
  get '/ui-elements-buttons', to: 'pages#ui-elements-buttons', as: 'ui-elements-buttons'
  get '/ui-elements-icons', to: 'pages#ui-elements-icons', as: 'ui-elements-icons'  
  get '/ui-elements-flash-message', to: 'pages#ui-elements-flash-message', as: 'ui-elements-flash-message'  
  get '/components-wizard', to: 'pages#components-wizard', as: 'components-wizard'  
  get '/components-calendar', to: 'pages#components-calendar', as: 'components-calendar'
  get '/components-maps', to: 'pages#components-maps', as: 'components-maps'
  get '/components-gallery', to: 'pages#components-gallery', as: 'components-gallery'
  get '/tables-static-table', to: 'pages#tables-static-table', as: 'tables-static-table'  
  get '/tables-dynamic-table', to: 'pages#tables-dynamic-table', as: 'tables-dynamic-table'  
  
  
  
  
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
