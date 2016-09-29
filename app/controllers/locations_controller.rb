class LocationsController < ApplicationController
  before_action :choose_location, only: [:show, :edit, :update]
  before_action :choose_game, only: [:index]

  def index
    @locations = Location.where(game_id: params[:game_id]).order(:id)
    current_player.current_game = @game
  end

  def show
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
      switch_turn = current_game.players.detect {|player| player.id != current_game.turn }
      @game.update(turn: switch_turn.id)
      redirect_to status_path(current_game)
    else
      binding.pry
      flash[:error] = "not right"
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
