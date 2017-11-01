Rails.application.routes.draw do
  resources :cloud_resources do
  end
  resources :cloud_storages do
    member do
      put 'list_folder_continue'
    end
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: "cloud_storages#index"
end
