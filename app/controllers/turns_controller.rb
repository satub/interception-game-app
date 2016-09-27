class TurnsController < ApplicationController

  def new
    @turn = Turn.new
  end
  def create
    @turn = Turn.create(player_id: params[:turn][:player_id])
    binding.pry
    @turn.update(turn_params)
    # binding.pry
    # @turn.update(turn_params)
    game = current_game
    ## create method for switching turn in the game model
    switch_turn = current_game.players.detect {|player| player.id != current_game.turn }
    game.update(turn: switch_turn.id)
    redirect_to status_path(current_game)
  end

  ##intercepts can call on show and edit HAHA
  def show
  end
  def edit
  end

  ##Show all turns after the game is over????
  def index
  end

  private
  def turn_params
    params.require(:turn).permit(:player_id, :header, location_ids:[], actions_attributes: [:number_of_troops, :action_type, :character_id, :location_id], locations_attributes: [:content, :player_id])
  end

end
