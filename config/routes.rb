Rails.application.routes.draw do
  root "accounts#index"
  resources :accounts do
    member do
      patch :upload
    end
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
