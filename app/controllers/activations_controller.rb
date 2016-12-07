class ActivationsController < ApplicationController
  def activate_share
    share = Share.find_by_id(params[:id])
    token = params[:token]

    if share && BCrypt::Password.new(share.activation_digest).is_password?(token)
      # use update_attribute to skip validation due to agreed attribute
      share.update_attribute('activated', true)
      flash[:success] = "Der Anteil wurde erfolgreich aktiviert!"
      log_in share
      redirect_to share
    else
      flash[:danger] = "Aktivierungs-Link ungültig!"
      redirect_to root_url
    end
  end

  private

  def activation_params
    params.require(:activation).permit(:share_id, :activation_token)
  end
end
