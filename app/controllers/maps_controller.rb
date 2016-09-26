class MapsController < ApplicationController

  def new
    @map = Map.new
  end

  def create
    binding.pry
    ##create locations:
  end

  def show
  end

  private
  def map_params
    params.require(:map).permit(:name, :size_y, :size_x, :style_link, :background_image_link, :game_id)
  end
end
