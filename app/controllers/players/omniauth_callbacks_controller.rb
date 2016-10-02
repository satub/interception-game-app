class Players::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def github
    @player = Player.from_omniauth(request.env["omniauth.auth"])
    sign_in_and_redirect @player
  end

  protected
   def after_sign_up_path_for(@player)
     root_path(@player)
   end

end
