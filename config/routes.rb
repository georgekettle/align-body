Rails.application.routes.draw do
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
  resources :saves, only: [:index]
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "pages#home"
end
