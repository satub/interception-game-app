class CharactersController < ApplicationController

  def new
    @player = current_player
    @character = Character.new
  end

  def create
    # binding.pry
    @player = current_player
    @character = Character.find_or_create_by(character_params)

    if @character.errors.empty?
      redirect_to player_characters_path(current_player)
    else
      flash[:error] = "Character creation failed."
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
    ##only shows the characters within the given team
  end

  private
  def character_params
    params.require(:character).permit(:name, :player_id, :role)
  end

end
