class CharactersController < ApplicationController
  before_action :set_player

  def new
    @character = Character.new
  end

  def create
    @character = Character.create(character_params)

    #######Refactor this hack########
    if @character.errors.empty? || params[:character][:id].last != ""
      if current_game
        GameCharacter.find_or_create_by(game_id: current_game.id, character_id: @character.id)
        if !params[:character][:id].empty?
          params[:character][:id].each do |assign|
            GameCharacter.find_or_create_by(game_id: current_game.id, character_id: assign)
          end
        end
      end
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
    params.require(:character).permit(:name, :player_id, :role, :image_link, :personality, :id)
  end

  def set_player
    @player = current_player
  end

end
