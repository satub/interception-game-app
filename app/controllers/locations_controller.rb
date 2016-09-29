class LocationsController < ApplicationController
  before_action :choose_location, only: [:show, :edit, :update]
  before_action :choose_game, only: [:index]

  def index
    @locations = Location.where(game_id: params[:game_id]).order(:id)
    current_player.current_game = @game
  end

  def show
    ###show the whole history for this location
  end

  def edit
  end

  def update
    binding.pry
    ##use model methods to check if this location can be overtaken. If not, notify of a failed attempt
    @location.update(location_params.merge(content: location_params[:character_locations_attributes]["0"]["message"]))
      binding.pry
    if @location.errors.empty?
      #on failed attempt:
      #@location.update(location_params.TAKEOFF(controlled_by))
      ##switch turn  =>>>> this needs to be a method of the game class
      @game.switch_turn

      redirect_to status_path(current_game)
    else
      ### ohmigod, this path works at least on some level!! :o
      binding.pry
      flash[:error] = "Something went oh-so wrong."
      render :edit
    end
  end




  private
    def choose_location
      @game = Game.find(params[:game_id])
      @location = Location.find(params[:id])
    end
    def location_params
      params.require(:location).permit(:content, :controlled_by, :character_ids, characters_attributes: [:energy, :status], character_locations_attributes: [:message, :character_id, :location_id, :troops_sent])
    end
    def choose_game
      @game = Game.find(params[:game_id])
    end
end
