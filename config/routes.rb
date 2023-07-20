Rails.application.routes.draw do
  devise_for :users
  root "home#index"

  resources :home, only: :index
    get "contact", to: "home#contact_new"
    post "contact", to: "home#contact_create"

  namespace :admin do
    resources :rooms
    resources :reservations

  resources :hotels do
    resources :rooms
    resources :amenities
    resources :activities
    resources :messages
  end

  resources :rooms do
    resources :reservations
    resources :calendars, only: [:index, :new, :create]
  end

  resources :reservations do
    resources :payments
  end

  resources :reviews
   
  end
end
