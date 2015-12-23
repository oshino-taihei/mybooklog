Rails.application.routes.draw do
  devise_for :users
  resources :books, param: :asin, only: [:index] do
    resource :review
  end
  resources :reviews, only: [:index]
  resource :home, only: [:index]
  root 'home#index'
end
