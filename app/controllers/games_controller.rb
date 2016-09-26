class GamesController < ApplicationController
  before_action :authenticate_player!, only: [:new, :create]

  def new
    @game = Game.new
  end

  def create
    @game = Game.create(game_params)
    GamePlayers.create(player_id: current_player.id, game_id: @game.id, creator: true)
    current_player.current_game = @game
    binding.pry
    redirect_to new_team_path
    #add direct somwhere else if this create fails
  end

  def index
    @games = Game.all
  end

  def show
    @game = Game.find(params[:id])
  end

  def history
    #possible route to viewing the history of all games played
  end

  private
    def game_params
      params.require(:game).permit(:title, :fandom)
    end
end
