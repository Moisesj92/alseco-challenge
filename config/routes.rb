Rails.application.routes.draw do
  resources :sales do
    member do
      put :add_products
      put :remove_products
    end
  end
  resources :products

  devise_for :users,
  controllers: {
      sessions: 'users/sessions',
      registrations: 'users/registrations'
  }

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
