Rails.application.routes.draw do
  devise_for :users
  resources :users, param: :name, only: [:index, :show]
  resources :books, param: :asin, only: [:index] do
    resource :review
  end
  resources :follows, only: [:create, :destroy]
  resource :home, only: [:index]
  root 'home#index'
end
