class GamesController < ApplicationController
  before_action :authenticate_player!, only: [:new, :create]
  before_action :choose_game, only: [:join, :show, :start, :status]

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
  end

  def join
    GamePlayer.create(player_id: current_player.id, game_id: @game.id, creator: false)
    current_player.current_game = @game
    redirect_to new_team_path
    # binding.pry
    #add direct somwhere else if this create fails
  end

  def start
    # binding.pry
    turn = @game.players.sample.id  #randomly choose player
    @game.update(status: params[:status], turn: turn)
    @game.map.assign_locations(@game.players)
    # game.update(game_params)
    ## call instance method to divvy up the map locations between the teams and set turn.
    ## This should open up the map for both, the one with turn active gets to set their moves
    ## the other waits with chance to examine the map.
    redirect_to map_path(@game.map)
  end


  def status
    ##check if all slots owned byt the same player/team. If so, gameover, otherwise forward to next turn
    ##These checks need model methods, move logic there !!
    binding.pry
    if current_game.players.collect {|player| current_game.map.locations.all?{|location| location.player == player.id}}.any?
      @game.update(status: "finished")
      ###add winner here, too
    else
      ###print a message here?
    end
    redirect_to map_path(current_game.map)
  end

  def history
    #possible route to viewing the history of all games played
  end

  private

    def choose_game
      @game = Game.find(params[:id])
    end

    def game_params
      params.require(:game).permit(:title, :fandom, :status)
    end
end
