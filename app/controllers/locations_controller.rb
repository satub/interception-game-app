class LocationsController < ApplicationController

  def index
    @locations = Location.where(game_id: current_game.id)
  end

  def show
    # binding.pry
    @location = Location.find(params[:id])
  end

  def edit
  end

  def update
  end

end
