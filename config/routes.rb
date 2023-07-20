# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users
  root "home#index"

  resources :home, only: :index
    get "contact", to: "home#contact_new"
    post "contact", to: "home#contact_create"

  namespace :admin do
    resources :rooms
    resources :reservations
   
  end
end
