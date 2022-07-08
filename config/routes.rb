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
  resources :orders, shallow: true do
    member do
      get :owner_show
      put :actived
      put :paid_users
    end
    resources :order_items, except: %i[index show]
  end
  resources :restaurants, shallow: true do
    resources :menu_items, except: %i[index show]
  end
  root to: "orders#index", as: "home"
end
