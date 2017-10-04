Rails.application.routes.draw do
  resources :cloud_storages
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: "cloud_storages#index"
end
