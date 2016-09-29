class GamesController < ApplicationController
  before_action :authenticate_player! #, only: [:new, :create]
  before_action :choose_game, only: [:join, :show, :start, :status, :generate_locations]

  def new
    @game = Game.new
  end

  def create
    @game = Game.create(game_params)
    if @game.errors.empty?
      GamePlayer.create(player_id: current_player.id, game_id: @game.id, creator: true)
      current_player.current_game = @game
      flash[:error].clear unless flash[:error].nil?
      redirect_to new_player_character_path(current_player)
    else
      flash[:error] = "Game creation failed."
      render :new
    end
  end


  def index
    @games = Game.pending_games
    flash[:notice] = "No open games found" if @games.empty?
  end

  def my_games
    @games = Game.my_games(current_player)
    flash[:notice] = "You don'thave any games yet" if @games.empty?
  end

  def show
    # binding.pry
  end

  def generate_locations
    @game.assign_locations([current_player])
    redirect_to game_path(@game)
  end

  def join
    GamePlayer.create(player_id: current_player.id, game_id: @game.id, creator: false)
    current_player.current_game = @game
    redirect_to new_player_character_path(current_player)
    # binding.pry
  end

  def start
    # binding.pry
    turn = @game.players.sample.id  #randomly choose first player
    @game.update(status: params[:status], turn: turn)
    @game.assign_locations(@game.players)

    redirect_to game_locations_path(@game)
  end


  def status
    ##check if all slots owned byt the same player/team. If so, gameover, otherwise forward to next turn
    ##These checks need model methods, move logic there !!
    binding.pry
    if current_game.players.collect {|player| current_game.locations.all?{|location| location.controlled_by == player.id}}.any?
      @game.update(status: "finished")
      ###add winner here, too
    else
      ###print a message here?
    end
    redirect_to game_locations_path(current_game)
  end



  private
    def choose_game
      !params[:game_id].nil? ? @game = Game.find(params[:game_id]) : @game = Game.find(params[:id])
    end

    def game_params
      params.require(:game).permit(:title, :status, :map_size, :map_name)
    end
end
