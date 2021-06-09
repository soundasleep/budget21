Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root "welcome#index"
  get "welcome/weeks"
  get "welcome/months"

  resources :accounts do
    member do
      patch :upload
    end
  end
  resources :categories
  resources :rules
end
