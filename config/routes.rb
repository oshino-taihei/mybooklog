Rails.application.routes.draw do
  devise_for :users
  resources :users, param: :name, only: [:index, :show]
  resources :categories, only: [:index, :update, :create, :destroy]
  resources :books, param: :asin, only: [:index] do
    resource :review
  end
  resources :follows, only: [:create, :destroy]

  root 'home#index'
end
