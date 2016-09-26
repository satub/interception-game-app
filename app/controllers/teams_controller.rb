class TeamsController < ApplicationController

  def new
    @team = Team.new
  end

  def create
    @team = Team.create(team_params)
        # binding.pry
    # current_game.teams << @team   ##figure out how to link teams to current_game
    redirect_to team_path(@team)
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
      params.require(:team).permit(:player_id, :name, :motto, :troops, :image_link, :style_link, :theme_link)
    end
end
