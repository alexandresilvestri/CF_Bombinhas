Rails.application.routes.draw do
  resources :workouts
  resources :tenants
  resources :weekly_schedules

  get "up" => "rails/health#show", as: :rails_health_check

  root "pages#home"
end
