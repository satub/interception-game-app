class CharactersController < ApplicationController
  before_action :set_player
  before_action :authenticate_player!

  def new
    @character = Character.new
  end

  def create
    if assign_only?
      new_hash = character_params.delete_if{|key, value| key != "game_characters_attributes"}
      Character.create(new_hash)
      redirect_to player_characters_path(current_player)
    else
      @character = Character.create(character_params)
      if @character.errors.empty?
        @character.game_characters.build(game_id: current_game.id)
        @character.save
        redirect_to player_characters_path(current_player)
      else
        flash[:error] = "Character creation failed. #{@character.errors.full_messages_for(:name).first}"
        render :new
      end
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
