Rails.application.routes.draw do
  root "cars#index"
  devise_for :users
  post 'checkout/sell/:id', to: "checkout#sell", as: :checkout_sell
  post 'checkout/rent/:id', to: "checkout#rent", as: :checkout_rent
  patch 'set_dealer', to: "cars#set_dealer", as: :set_dealer
  get 'search_for_cars', to: 'cars#search_for_cars'
  resources :cars do
    delete 'delete_car_image', on: :member
  end
end
