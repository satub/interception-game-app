class MapsController < ApplicationController

  def new
    @map = Map.new
  end

  def create
    # binding.pry
    @map = Map.create(map_params)
    ###MAP NEEDS A VALIDATION AGAINST LETTERS AND EMPTY VALUES IN THE SIZE BOXES!!!
    @map.assign_locations if @map.no_locations?
    redirect_to map_path(@map)
  end

  def show
    @map = Map.find(params[:id])
  end

  private
  def map_params
    params.require(:map).permit(:name, :size_y, :size_x, :style_link, :background_image_link, :game_id)
  end
end
