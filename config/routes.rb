Rails.application.routes.draw do
  resources :sales do
    member do
      put :add_products
      put :remove_products
    end
    collection do
      post :by_user
      post :average_age_buyers
    end
  end

  resources :products do
    collection do
      get :my_products
    end
  end

  namespace :users do
    get ':id/sales', :to => "users#sales"
  end 

  devise_for :users,
  controllers: {
      sessions: 'users/sessions',
      registrations: 'users/registrations'
  }

end
