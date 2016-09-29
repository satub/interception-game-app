class CharactersController < ApplicationController
  before_action :set_player
  
  def new
    @character = Character.new
  end

  def create
    # binding.pry
    @character = Character.create(character_params)

    if @character.errors.empty?
      binding.pry
      GameCharacter.create(game_id: current_game.id, character_id: @character.id)
      redirect_to player_characters_path(current_player)
    else
      flash[:error] = "Character creation failed. #{@character.errors.full_messages_for(:name).first}"
      render :new
    end
  end

  def edit
  end

  def update
  end

  def show
    @character = Character.find(params[:id])
  end

  def index
    ##only shows the characters for the current player
    @characters = @player.characters
  end

  private
  def character_params
    params.require(:character).permit(:name, :player_id, :role, :image_link, :personality)
  end

  def set_player
    @player = current_player
  end

end
