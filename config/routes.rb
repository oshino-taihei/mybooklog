Rails.application.routes.draw do
  devise_for :users
  resources :users, only: [:index, :show]
  resources :books, param: :asin, only: [:index] do
    resource :review
  end
  resource :home, only: [:index]
  root 'home#index'
end
