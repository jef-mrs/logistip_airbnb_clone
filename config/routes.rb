Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'
  resources :flats, only: [:index, :show, :new, :create, :edit, :update, :destroy] do
    resources :bookings, only: [:create]
  end
  resources :bookings, only: [:show, :edit, :destroy, :update]

  get 'dashboard', to: 'pages#dashboard'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  patch 'bookings/:id/validate', to: 'bookings#validate', as: 'valid'
end
