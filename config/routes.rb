# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users, controllers: { sessions: "users/sessions" }
  devise_scope :user do
    get "/users/sign_out" => "devise/sessions#destroy"
  end
  resource :users do
    member do
      resource :multi_factor_authentication, only: %i[new create show edit destroy], module: :users
    end
  end
  get "orders/active"
  get "orders/history"
  resources :orders do
    put :actived, on: :member
  end
  root to: "orders#index", as: "home"
end
