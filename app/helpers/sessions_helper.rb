module SessionsHelper
  def log_in(share)
    session[:share_id] = share.id
  end

  def log_out
    session.delete(:share_id)
    @current_share = nil
  end

  def admin?
    session[:admin]
  end

  def restricted_admin?
    session[:restricted_admin]
  end

  def current_share
    @current_share ||= Share.find_by(id: session[:share_id])
  end

  def current_share?
    current_share && (current_share.id == params[:id].to_i || current_share.id == params[:share_id].to_i)
  end

  def admin_or_current_share
    unless (current_share && current_share?) || admin? || restricted_admin?
      flash[:danger] = 'Nicht erlaubt!'
      redirect_to root_path
    end
  end

  def authenticate
    if Rails.env.production?
      admin_user = ENV['htaccess_login_admin']
      admin_password = ENV['htaccess_passwd_admin']
      restricted_admin_user = ENV['htaccess_login_admin_restricted']
      restricted_admin_password = ENV['htaccess_passwd_admin_restricted']
    else
      admin_user = 'admin'
      admin_password = 'secret'
      restricted_admin_user = 'restricted_admin'
      restricted_admin_password = 'secret'
    end

    authenticate_or_request_with_http_basic('Administration') do |username, password|
      if (username == admin_user && password == admin_password)
        session[:admin] = true
      elsif (username == restricted_admin_user && password == restricted_admin_password)
        session[:restricted_admin] = true
      end
    end
  end
end
