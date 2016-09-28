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
  end

  private
    def choose_location
      @location = Location.find(params[:id])
    end
    def location_params
      params.require(:location).permit(:content, :controlled_by, character_ids:[], characters_attributes: [:energy, :status], character_locations_attributes: [:messages, :character_id, :location_id, :troops_sent])
    end
end
