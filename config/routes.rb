Rails.application.routes.draw do
  devise_for :players, :controllers =>  {:registrations => 'players/registrations', :omniauth_callbacks => "players/omniauth_callbacks" }
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: "welcome#home"
  get '/about' => "welcome#about"

  resources :teams do
    resources :characters
  end
  resources :games

  resources :maps do
    resources :locations
  end
end
