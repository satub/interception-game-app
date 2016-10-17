class GamesController < ApplicationController

  before_action :housekeeping, except: :status
  before_action :authenticate_player!
  before_action :choose_game, only: [:join, :show, :start, :status, :generate_locations]

  def new
    @game = Game.new
  end

  def create
    @game = Game.create(game_params)
    if @game.errors.empty?
      GamePlayer.create(player_id: current_player.id, game_id: @game.id, creator: true)
      current_player.current_game = @game

      redirect_to new_player_character_path(current_player)
    else
      flash[:error] = "Game creation failed."
      render :new
    end
  end


  def index
    @games = Game.all

    #### Move this to different action OR into JS object Model property yada thingy
    # @games = Game.pending_games
    # flash[:notice] = "No open games found" if @games.empty?
    render json: @games
  end

  def my_games
    @games = Game.my_games(current_player)
    flash[:notice] = "You don't have any games yet" if @games.empty?
    render :index
  end

  def show
  end

  def generate_locations
    @game.assign_locations([current_player])
    redirect_to game_path(@game)
  end

  def join
    GamePlayer.create(player_id: current_player.id, game_id: @game.id, creator: false)
    current_player.current_game = @game
    redirect_to new_player_character_path(current_player)
  end

  def start
    turn = @game.players.sample.id  #randomly choose first player
    @game.update(status: params[:status], turn: turn)
    @game.assign_locations(@game.players)
    @game.configure_characters
    redirect_to game_locations_path(@game)
  end


  def status
    if @game.game_over?
      @game.update(status: "finished", winner: @game.winner_id, turn: nil)
    end
    flash.keep(:message)
    redirect_to game_locations_path(current_game)
  end


  private
    def choose_game
      !params[:game_id].nil? ? @game = Game.find(params[:game_id]) : @game = Game.find(params[:id])
    end

    def game_params
      params.require(:game).permit(:title, :status, :map_size, :map_name, :winner)
    end
end
