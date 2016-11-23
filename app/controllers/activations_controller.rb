class ActivationsController < ApplicationController
  def edit
    token = params[:token]
    token_digest = BCrypt::Password.new(token)
    
    share = Share.find_by(activation_token: token)
    stored_digest = share.activation_digest

    if stored_digest == token_digest 
      share.update_attributes(activated: true)
      flash.now[:success] = "Der Anteil wurde erfolgreich aktiviert!"
      redirect_to root_url
    else
      flash.now[:danger] = "Irgendwas ist schief gegangen, wir konnten den Anteil leider nicht aktivieren..."
      redirect_to root_url
    end
  end
end
