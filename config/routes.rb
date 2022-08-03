Rails.application.routes.draw do
  root "cars#index"
  devise_for :users
  resources :cars do
    delete 'delete_car_image', on: :member
  end
end
