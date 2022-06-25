Rails.application.routes.draw do
  resources :products
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "dashboard#welcome"

  get    '/sales/:id', to: 'sales#show', as: 'sale'
  post   '/sales/', to: 'sales#create'
  patch  '/sales/:id', to: 'sales#update'
  delete '/sales/:id', to: 'sales#destroy'


end
