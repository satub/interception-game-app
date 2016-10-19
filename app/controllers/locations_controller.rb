class LocationsController < ApplicationController
  before_action :housekeeping, except: :index
  before_action :choose_location, only: [:show, :edit, :update]
  before_action :choose_game, only: [:index]
  before_action :quick_hash_access, only: [:update]
  before_action :authenticate_player!

  def index
    @locations = Location.where(game_id: params[:game_id]).order(:id)
    current_player.current_game = @game  ##this is a hack, only change player's current_game if they join in a new game or switch between their own games
  end

  def show
    @history = @location.history
    render json: @location
  end

  def edit
    render json: [@game, @location]
  end

  def update
    if valid_takeover_attempt?
      if can_be_taken?
        params[:location][:character_locations_attributes]["0"][:success] = true
        @location.update(location_params.merge(content: @address[:message]))
      else
        params[:location][:character_locations_attributes]["0"][:success] = false
        @location.update(location_params.delete_if{|key, value| key == "controlled_by"})
        flash[:message] = "Attempt to take over location failed."
        flash.keep(:message)
      end
      @game.switch_turn
      redirect_to status_path(current_game)
    else
      flash[:error] = "Something went oh-so wrong. Check the following: 1) Message can't be empty. 2) Number of troops must be a number."
      render :edit
    end
  end




  private
    def choose_game
      @game = Game.find(params[:game_id])
    end

    def choose_location
      choose_game
      @location = Location.find(params[:id])
    end

    def location_params
      params.require(:location).permit(:content, :controlled_by, character_locations_attributes: [:message, :character_id, :location_id, :troops_sent, :success])
    end

    def valid_takeover_attempt?
      CharacterLocation.new(message: @address[:message], troops_sent: @address[:troops_sent]).valid?
    end

    def can_be_taken?   ###REFACTOR THIS !!!!
      @location.defense
      character = Character.find(@address[:character_id])
      trial = character.attack(@address[:troops_sent].to_i)
      energy = character.game_characters.detect{|gc| gc.game_id == current_game.id}.troops
      @location.defense < trial && @address[:troops_sent].to_i < energy
    end

    def quick_hash_access
      @address = location_params[:character_locations_attributes]["0"]
    end

end
