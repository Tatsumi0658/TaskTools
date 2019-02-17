Rails.application.routes.draw do
  resources :todotasks
  root 'todotasks#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
