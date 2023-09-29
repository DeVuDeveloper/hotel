# frozen_string_literal: true

require "sidekiq/web"

Rails.application.routes.draw do
  get "newsletter_subscribers/new"
  get "newsletter_subscribers/create"
  get "newsletter_subscribers/destroy"
  get "notifications/index"
  resources :notification_messages

  devise_for :users, controllers: {
    omniauth_callbacks: "users/omniauth_callbacks"
  }
  root "hotels#index"
  post "/generate_calendars", to: "rooms#generate_calendars", as: :generate_calendars

  namespace :admin do
    namespace :dashboard do
      resources :hotels do
        resources :rooms do
          member do
            get :edit_seasonal_prices
            patch :update_seasonal_prices
            resources :calendars
            post "/generate_calendars", to: "rooms#generate_calendars", as: :generate_calendars
            resources :reservations
          end
        end
      end
      resources :users
      resources :user_messages
      resources :notification_messages
      resources :newsletters do
        post "subscribe", on: :collection
      end
      resources :push_notifications, except: %i[edit update] do
        post "send_notification", on: :member
        post "subscribe", on: :collection
      end
    end
  end

  get "unsubscribe/:user_id/:token", to: "admin/dashboard/newsletters#unsubscribe", as: "unsubscribe_newsletter"

  namespace :manager do
    get "dashboard", to: "dashboard#index"
  end

  resources :home, only: :index
  get "contact", to: "hotels#contact_new"
  post "contact", to: "hotels#contact_create"

  resources :hotels do
    resources :rooms
    resources :amenities
    resources :activities
    resources :messages
    resources :reviews
  end

  resources :rooms do
    resources :reservations do
      member do
        put :cancel
        get :availability
        patch :confirm
      end
      get "reservation_total_price", on: :collection
    end
    resources :calendars do
      resources :calendar_entries, only: :index
    end
    member do
      post 'like'
    end
    get 'favorite', on: :collection
  end

  get "calculate_total_price", to: "reservations#calculate_total_price"
  resources :reservations do
    resources :payments
  end
  post "/chatbot/receive_message", to: "chatbot#receive_message"
  resources :notifications, only: [:index]
  resources :newsletter_subscribers, only: %i[new create destroy]
  post '/api/send-location', to: 'api#send_location'
  get '/search', to: 'search#search_results'
  mount Sidekiq::Web => "/sidekiq"
end
