class ActivationsController < ApplicationController
  def activate_share
    share = Share.find_by(params[:share_id])
    token = params[:token]
    authenticated = BCrypt::Password.new(share.activation_digest).is_password?(token)
    
    if share && authenticated
      share.update_attributes(activated: true)
      flash.now[:success] = "Der Anteil wurde erfolgreich aktiviert!"
      redirect_to root_url
    else
      flash.now[:danger] = "Aktivierungs-Link ungültig!"
      redirect_to root_url
    end
  end

  private

  def activation_params
    params.require(:activation).permit(:share_id, :activation_token)
  end
end
