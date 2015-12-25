Rails.application.routes.draw do
  devise_for :users
  # devise_for :users, controllers: {
  #   sessions: 'users/sessions'
  # }
  resources :books, param: :asin, only: [:index] do
    resource :review
  end
  resources :reviews, only: [:index]
  resource :home, only: [:index]
  root 'home#index'
end
