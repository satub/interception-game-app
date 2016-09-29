class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
    before_action :housekeeping

  def current_game
    current_player.current_game
  end

  def housekeeping
    flash.clear
  end

  
end
