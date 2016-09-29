class LocationsController < ApplicationController
  before_action :choose_location, only: [:show, :edit, :update]
  before_action :choose_game, only: [:index]

  def index
    @locations = Location.where(game_id: params[:game_id]).order(:id)
    current_player.current_game = @game  ##this is a hack, only change player's current_game if they join in a new game or switch between their own games
  end

  def show
    @history = @location.history
  end

  def edit
  end

  def update
    ##use model methods to check if this location can be overtaken. If not, notify of a failed attempt
    if valid_takeover?
      @location.update(location_params.merge(content: location_params[:character_locations_attributes]["0"]["message"]))
      @game.switch_turn
      redirect_to status_path(current_game)
    else
      flash[:error] = "Something went oh-so wrong. Check the following: 1) Message can't be empty. 2) Number of troops must be a number."
      render :edit
    end
  end




  private
    def choose_location
      @game = Game.find(params[:game_id])
      @location = Location.find(params[:id])
    end

    def choose_game
      @game = Game.find(params[:game_id])
    end

    def location_params
      params.require(:location).permit(:content, :controlled_by, :character_ids, characters_attributes: [:energy, :status], character_locations_attributes: [:message, :character_id, :location_id, :troops_sent])
    end

    def valid_takeover?
      c_l_params = params[:location][:character_locations_attributes]["0"]
      CharacterLocation.new(message: c_l_params[:message], troops_sent: c_l_params[:troops_sent]).valid?
    end
end
