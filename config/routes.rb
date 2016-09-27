Rails.application.routes.draw do
  devise_for :players, :controllers =>  {:registrations => 'players/registrations', :omniauth_callbacks => "players/omniauth_callbacks" }
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  #Static Routes
  root to: "welcome#home"
  get '/about' => "welcome#about"

  #Routes for Game Controller
  resources :games, only: [:index, :show, :new, :create]
  get '/games/:id/join' => "games#join", as: '/join'
  post '/games/:id/start' => "games#start", as: '/start'
  get '/games/:id/status' => "games#status", as: '/status'

  #Routes for Characters
  resources :players, only: [:show, :edit, :update] do
    resources :characters, except: :destroy
  end
  # resources :teams

  #Routes for Map
  resources :maps, only: [:new, :create, :show, :edit, :update] do
    resources :locations, only: [:show]
  end
  # resources :turns
end
