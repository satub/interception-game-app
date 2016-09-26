class CharactersController < ApplicationController

  def new
    @team = Team.find(params[:team_id])
    @character = Character.new
  end

  def create
    # binding.pry
    @character = Character.create(character_params)
    binding.pry
    @team = Team.find(params[:character][:team_id])

    # @character.team = @team
    redirect_to team_path(@team)
    ##add path to failed creation
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
    params.require(:character).permit(:name, :team_id, :image_link, :role, :deployed, :personality, :status, :level)
  end

end
