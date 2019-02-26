Rails.application.routes.draw do
  root 'todotasks#index'
  resources :sessions, only:[:new, :create, :destroy]
  resources :users
  resources :todotasks
  concern :paginatable do
    get '(page/:page)', action: :index, on: :collection, as: ''
  end

  resources :my_resources, concerns: :paginatable
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
