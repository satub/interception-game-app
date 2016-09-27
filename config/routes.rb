Rails.application.routes.draw do
  devise_for :players, :controllers =>  {:registrations => 'players/registrations', :omniauth_callbacks => "players/omniauth_callbacks" }
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: "welcome#home"
  get '/about' => "welcome#about"
  get '/games/:id/join' => "games#join", as: '/join'
  post '/games/:id/start' => "games#start", as: '/start'
  get '/games/:id/status' => "games#status", as: '/status'

  resources :players do
    resources :characters
  end
  # resources :teams
  resources :games

  # resources :maps do
    resources :locations
  # end

  resources :turns
end
