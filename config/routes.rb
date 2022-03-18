Rails.application.routes.draw do
  get 'errors/not_found'
  get 'errors/internal_server_error'
  # Sidekiq Web UI, only for admins.
  require "sidekiq/web"
  authenticate :user, ->(user) { user.admin? } do
    mount Sidekiq::Web => '/sidekiq'
    get 'dashboard', to: 'dashboard#dashboard', as: :dashboard
    namespace :dashboard do
      # DASHBOARD_CLASSES set in 'config/initializers/dashboard_classes.rb'
      DASHBOARD_CLASSES.each do |klass|
        resources klass.pluralize.underscore.to_sym
      end
    end
  end
  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations',
    passwords: 'users/passwords'
  }
  resources :instructors, only: [:show, :index]
  resources :workouts, only: [:show, :index] do
    post 'toggle_save', to: 'saves#toggle', as: :toggle_save
  end
  resources :daily_workouts, only: [:index, :new, :create, :destroy]
  get 'account', to: 'accounts#account', as: :account
  get 'account_settings', to: 'accounts#account_settings', as: :account_settings
  resources :saves, only: :index
  resources :categories, only: :show
  get 'terms', to: 'policies#terms', as: :terms
  get 'privacy', to: 'policies#privacy', as: :privacy
  get 'contact', to: 'pages#contact', as: :contact
  get 'help', to: 'pages#help', as: :help
  get 'about', to: 'pages#about', as: :about
  post 'sms_upgrade/:user_id', to: 'sms_upgrade#create', as: :sms_upgrade
  post 'sms_upgrade_callback/:user_id', to: 'sms_upgrade#twilio_callback', as: :sms_upgrade_callback
  
  # Spotify
  get '/auth/spotify/callback', to: 'oauth#spotify_callback', as: :auth_spotify
  get '/auth/spotify', to: 'oauth#spotify_login', as: :spotify_login

  # direct errors to errors_controller
  match "/404", :to => "errors#not_found", :via => :all
  match "/500", :to => "errors#internal_server_error", :via => :all
  # Defines route for logged in user ("/")
  root to: "workouts#index", constraints: -> (r) { r.env["warden"].authenticate? }, as: :authenticated_root
  root "pages#home"
end
