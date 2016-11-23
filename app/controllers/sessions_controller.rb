class SessionsController < ApplicationController
  def new
  end

  def create
    share = Share.find_by(email: params[:session][:email].downcase)
    if share && share.authenticate(params[:session][:password])
      log_in share
      redirect_to share
    else
      flash[:danger] = 'Ungültig!'
      render :new
    end
  end

  def destroy
  end
end