class Players::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def github
    @player = Player.from_omniauth(request.env["omniauth.auth"])
    sign_in_and_redirect @player
  end

   # 
  #  def after_sign_up_path_for(resource)
  #    signed_in_root_path(resource)
  #  end

end
