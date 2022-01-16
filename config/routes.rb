Rails.application.routes.draw do
  # Sidekiq Web UI, only for admins.
  require "sidekiq/web"
  authenticate :user, ->(user) { user.admin? } do
    mount Sidekiq::Web => '/sidekiq'
    get 'dashboards/dashboard', to: 'dashboards#dashboard', as: :dashboard
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
  get 'account', to: 'accounts#account', as: :account
  resources :saves, only: :index
  resources :categories, only: :show
  get 'terms', to: 'policies#terms', as: :terms
  get 'privacy', to: 'policies#privacy', as: :privacy
  get 'contact', to: 'pages#contact', as: :contact
  post 'sms_upgrade_callback/:user_id', to: 'sms_upgrade#twilio_callback', as: :sms_upgrade_callback

  # Defines the root path route ("/")
  root "pages#home"
end
