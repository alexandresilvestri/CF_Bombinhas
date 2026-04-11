Rails.application.routes.draw do
  devise_for :users
  resources :workouts
  resources :users, except: [ :create ]
  get "up" => "rails/health#show", as: :rails_health_check

  root "pages#home"
end
