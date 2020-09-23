class AdminSessionsController < ApplicationController
  def new
  end

  def create
    admin = Admin.find_by(email: params[:admin_session][:email].downcase)
    if !admin
      flash[:danger] = 'Es gibt keinen Admin mit dieser Emailadresse!'
      render :new
    elsif admin.authenticate(params[:admin_session][:password])
      log_out
      admin_log_out
      admin_log_in admin
      redirect_to stations_path
    else
      flash[:danger] = 'Ungültiges Passwort!'
      render :new
    end
  end

  def destroy
    admin_log_out
    redirect_to :root
  end
end
