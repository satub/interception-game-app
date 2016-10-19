class CharactersController < ApplicationController
  before_action :set_player
  before_action :authenticate_player!

  def new
    @character = Character.new
    render layout: false
  end

  def create
    if assign_only?
      new_hash = character_params.delete_if{|key, value| key != "game_characters_attributes"}
      character = Character.create(new_hash)
      # redirect_to player_characters_path(current_player)
      render json: character
    else
      @character = Character.create(character_params)
      if @character.errors.empty?
        @character.game_characters.create(game_id: current_game.id, character_id: @character.id) if current_game
        # redirect_to player_characters_path(current_player)
        render json: @character
      else
        flash[:error] = "Character creation failed. #{@character.errors.full_messages_for(:name).first}"
        render json: @character.errors, status: 422
        # render :new
      end
    end
  end

  def edit
  end

  def update
  end

  def show
    @character = Character.find(params[:id])
    render json: @character
  end

  def index
    ##only shows the characters for the current player
    @characters = @player.characters
    render json: @characters
  end


  private
    def character_params
      params.require(:character)
      .permit(:name, :player_id, :role, :image_link, :personality, :game_characters_attributes => [:game_id, :character_id => []])
    end

    def set_player
      @player = current_player
    end

    def assign_only?
      if character_params[:game_characters_attributes]
        character_params[:name] == "" && character_params[:game_characters_attributes]["0"][:character_id].last != ""
      end
    end

end
