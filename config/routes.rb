Rails.application.routes.draw do
  resources :users
  resources :gyms
  get "up" => "rails/health#show", as: :rails_health_check

  root "pages#home"
end
