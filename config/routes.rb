Rails.application.routes.draw do
  devise_for :users
  resources :workout_weekly_schedules

  get "up" => "rails/health#show", as: :rails_health_check

  root "pages#home"
end
