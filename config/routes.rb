Rails.application.routes.draw do
  devise_for :users

  root "home#index"
  post '/generate_calendars', to: 'rooms#generate_calendars', as: :generate_calendars

  namespace :admin do
    namespace :dashboard do
      resources :hotels do
        resources :rooms do
          member do
            get :edit_seasonal_prices
            patch :update_seasonal_prices
            resources :calendars
            post '/generate_calendars', to: 'rooms#generate_calendars', as: :generate_calendars
            resources :reservations
          end
        end
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
      member do
        put :cancel
        get :availability
      end
      get "reservation_total_price", on: :collection
    end
    resources :calendars do
      resources :calendar_entries, only: :index
    end
  end

  get "calculate_total_price", to: "reservations#calculate_total_price"
  resources :reservations do
    resources :payments
  end

  resources :reviews
end
