Rails.application.routes.draw do
 
root to: 'application#welcome'

get '/inventories/deliveryweek', to: 'inventories#deliveryweek', as: 'totalsale'
get '/auth/:provider/callback', to: 'sessions#omniauth'
get '/signup', to: 'users#new'
post '/signup', to: 'users#create'
get 'login', to: 'sessions#new'
post 'login', to: 'sessions#create'
get 'welcome', to: 'sessions#welcome'
post '/logout', to: 'sessions#destroy'





  resources :users,  only: [:new, :create, :index] do 
  resources :inventories
  end
  resources :inventories
  resources :products, only: [:index, :show]

  get '/', to: 'application#welcome'



end
