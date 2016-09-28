class LocationsController < ApplicationController
  before_action :choose_location, only: [:show, :edit, :update]

  def index
    @locations = Location.where(game_id: current_game.id)
  end

  def show
  end

  def edit
  end

  def update
    binding.pry
    ##use model methods to check if this location can be overtaken. If not, notify of a failed attempt
    @location.update(location_params)

    redirect_to game_locations_path(current_game)
  end

  private
    def choose_location
      @location = Location.find(params[:id])
    end
    def location_params
      params.require(:location).permit(:content, :controlled_by, :character_ids, characters_attributes: [:energy, :status], character_locations_attributes: [:message, :character_id, :location_id, :troops_sent])
    end
end
