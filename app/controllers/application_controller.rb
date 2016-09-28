class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def current_game
    current_player.current_game
  end

  def housekeeping
    ##Add some method here to clean the flash messages, errors, etc upon redirects
  end
end
