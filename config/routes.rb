Rails.application.routes.draw do
  devise_for :users

  root "home#index"

  namespace :admin do
    namespace :dashboard do
      resources :hotels do
        resources :rooms
          resources :calendars, only: [:new, :create]
      end
      resources :users
    end
  end

  namespace :manager do
    get "dashboard", to: "dashboard#index"
  end

  resources :home, only: :index
  get "contact", to: "home#contact_new"
  post "contact", to: "home#contact_create"

  resources :hotels do
    resources :rooms
    resources :amenities
    resources :activities
    resources :messages
  end

  resources :rooms do
    resources :reservations do
      get 'reservation_total_price', on: :collection
    end
    
    resources :calendars, only: [:index, :new, :create]
  end

  get 'calculate_total_price', to: 'reservations#calculate_total_price'
  resources :reservations do
    resources :payments
  end

  resources :reviews
end
