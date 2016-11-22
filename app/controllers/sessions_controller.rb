class SessionsController < ApplicationController
  def new
  end

  def create
    share = Share.find_by(email: session_params[:email].downcase)
    if share && share.authenticate(session_params[:password])
      debugger
      log_in share
      redirect_to share
    else
      flash[:danger] = 'Ungültig!'
      render :new
    end
  end

  def session_params
    params.require(:session).permit(:email, :password)
  end

  def destroy
  end
end