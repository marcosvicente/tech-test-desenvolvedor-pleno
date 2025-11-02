Rails.application.routes.draw do
  resources :upload_files, only: [:create, :index, :new]

  get "customers", to: "customers#index"

  get "up" => "rails/health#show", as: :rails_health_check


end
