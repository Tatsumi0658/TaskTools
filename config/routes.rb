Rails.application.routes.draw do
  root 'todotasks#index'
  resources :sessions, only:[:new, :create, :destroy]
  resources :users, only:[:new, :create, :show, :destroy]
  resources :todotasks
  concern :paginatable do
    get '(page/:page)', action: :index, on: :collection, as: ''
  end

  resources :my_resources, concerns: :paginatable

  namespace :admin do
    resources :users
  end
end
