class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def current_game
    current_player.current_game
  end

    
end
