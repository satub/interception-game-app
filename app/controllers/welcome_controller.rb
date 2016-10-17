class WelcomeController < ApplicationController

  def home
  end

  def about
    render :layout => false
  end

end
