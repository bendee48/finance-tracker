Rails.application.routes.draw do
  get 'stocks/search'
  root 'welcome#index'
  devise_for :users
  get 'my_portfolio', to: 'users#my_portfolio'
  get 'search_stocks', to: 'stocks#search'
end
