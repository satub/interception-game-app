class LocationsController < ApplicationController

  def index
    ##shows only the locations connected to a specific map
  end

  def show
    # binding.pry
    @location = Location.find(params[:id])
  end

  def edit
  end

  def update
  end

end
