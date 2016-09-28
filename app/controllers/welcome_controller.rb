class WelcomeController < ApplicationController

  def home
    flash[:error] = nil
  end

  def about
    flash[:error] = nil
  end

end
