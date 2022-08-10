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
  # for paypal payment
  get 'paypal_car_payment', to: "cars#paypal_car_payment"
  post :create_paypal_car, :to => 'cars#create_paypal_car'
  post :capture_paypal_car, :to => 'cars#capture_paypal_car'
end
