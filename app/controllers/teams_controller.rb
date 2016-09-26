class TeamsController < ApplicationController

  def new
    @team = Team.new
  end

  def create
    binding.pry
    @team = Team.create(team_params)
    current_game.teams << @team
    redirect_to new_team_character_path(@team)
  end

  def show
    @team = Team.find(params[:id])
  end

  def index
    @teams = current_game.teams
    ##this will only show the teams for the current_game
  end

  private
    def team_params
      params.require(:game).permit(:player_id, :name, :motto, :troops, :image_link, :style_link, :theme_link)
    end
end
