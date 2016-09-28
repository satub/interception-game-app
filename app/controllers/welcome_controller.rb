class WelcomeController < ApplicationController

  def home
    flash[:error] = nil
    flash[:notice] = nil
  end

  def about
    flash[:error] = nil
    flash[:notice] = nil
  end

end
