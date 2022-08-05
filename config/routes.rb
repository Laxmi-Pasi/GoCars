Rails.application.routes.draw do
  root "cars#index"
  devise_for :users
  post 'checkout/create/:id', to: "checkout#create", as: :checkout_create
  patch 'set_dealer', to: "cars#set_dealer", as: :set_dealer
  resources :cars do
    delete 'delete_car_image', on: :member
  end
end
