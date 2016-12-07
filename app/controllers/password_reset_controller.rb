class PasswordResetController < ApplicationController
  before_action :set_share, only: [:reset_password, :set_new_password]
  before_action :set_share_by_email, only: [:create_password_reset]
  before_action :authenticated?, only: [:reset_password]

  def request_password_reset
  end
  
  def create_password_reset
    @share.create_digest_for(attribute: 'password_reset')
    if @share.save
      MessageMailer.send_password_reset_link(@share).deliver_now
      flash[:success] = "Ein Link zum Zurücksetzen deines Passworts wurde dir zugeschickt. Dieser ist 24h gültig!"
    else
      flash[:danger] = "Etwas ist schiefgegangen, wir können dein Passwort leider nicht zurücksetzen..."
    end

    redirect_to root_url
  end

  def reset_password
    render 'password_reset_form', locals: { password_reset_token: params[:token], share_id: @share.id }
  end

  def set_new_password
    if passwords_match?
      new_password = params[:new_password][:password]
      @share.update_attributes(password: new_password,
                               password_confirmation: new_password,
                               password_reset_digest: nil) 
      flash[:success] = "Das neue Passwort wurde erfolgreich gesetzt!"
      redirect_to root_url
    else
      flash[:danger] = "Die eingegebenen Passwörter stimmen nicht überein!"
      render :set_new_password
    end
  end

  private

  def set_share_by_email
    unless @share = Share.find_by(email: params[:password_reset][:email])
      flash[:danger] = "Zu dieser Email-Adresse wurde kein passender Account gefunden!"
      redirect_to root_url
    end
  end

  def set_share
    @share = Share.find_by(id: params[:id]) 
  end

  def authenticated?
    unless @share && token_valid? 
      flash[:danger] = "Link zum Passwort zurücksetzen ist ungültig!"
      redirect_to root_url
    end
  end

  def token_valid?
    @share.authenticated?(attribute: :password_reset, token: params[:token]) && @share.password_reset_token_alive?
  end

  def passwords_match?
    params[:password] == params[:password_confirmation]
  end
end
