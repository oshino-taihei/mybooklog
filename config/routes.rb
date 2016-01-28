Rails.application.routes.draw do
  devise_for :users
  resources :users, param: :name, only: [:index, :show] do
    resource :follow, only: [:create, :destroy]
  end
  resources :categories, only: [:index, :update, :create, :destroy]
  resources :books, param: :asin, only: [:index] do
    resource :review, except: [:new, :show]
  end

  root 'home#index'
end
