Rails.application.routes.draw do
  resources :ideas
  resources :users, :only => :show

  get '/sessions/new', to: 'sessions#new', as: 'new_session'
  get '/auth/:provider/callback', to: 'sessions#create'
  get "/signout" => "sessions#destroy", :as => :signout

  root :to => 'ideas#new'
end