Rails.application.routes.draw do
  root 'welcome#index'
  resources :user_stocks, only: [:create, :destroy]
  resources :friendships, only: [:create, :destroy]
  get 'friends', to: 'friendships#index'
  get 'search_friends', to: 'friendships#search'
  devise_for :users
  get 'my_portfolio', to: 'users#my_portfolio'
  get 'search_stocks', to: 'stocks#search'
end
