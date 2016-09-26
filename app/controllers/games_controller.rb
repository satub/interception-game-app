class GamesController < ApplicationController
  before_action :authenticate_player!, only: [:new, :create]

  def new
    @game = Game.new
  end

  def create
    @game = Game.create(game_params)
    GamePlayer.create(player_id: current_player.id, game_id: @game.id, creator: true)
    current_player.current_game = @game
    # binding.pry
    redirect_to new_team_path
    #add direct somwhere else if this create fails
  end

  def index
    @games = Game.all
  end

  def show
    @game = Game.find(params[:id])
  end

  def join
    @game = Game.find(params[:id])
    GamePlayer.create(player_id: current_player.id, game_id: @game.id, creator: false)
    current_player.current_game = @game
    redirect_to new_team_path
    # binding.pry
    #add direct somwhere else if this create fails
  end

  def start
    binding.pry
    @game = Game.find(params[:id])
    game.update(game_params)
    ## call instance method to divvy up the map locations between the teams and set turn.
    ## This should open up the map for both, the one with turn active gets to set their moves
    ## the other waits with chance to examine the map.
  end


  def history
    #possible route to viewing the history of all games played
  end

  private
    def game_params
      params.require(:game).permit(:title, :fandom, :status)
    end
end
