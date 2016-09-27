class TurnsController < ApplicationController

  def new
    @turn = Turn.new
  end
  def create
    binding.pry
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
    params.require(:turn).permit()
  end

end
