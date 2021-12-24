Rails.application.routes.draw do
  devise_for :users
  resources :instructors, only: [:show, :index]
  resources :workouts, only: [:index]
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "pages#home"
end
