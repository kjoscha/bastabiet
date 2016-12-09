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

  def current_share
    @current_share ||= Share.find_by(id: session[:share_id])
  end

  def current_share?
    current_share.id == params[:id].to_i || current_share.id == params[:share_id].to_i
  end

  def logged_in?
    !current_share.nil?
  end

  def admin_or_current_share
    unless (current_share && current_share?) || admin?
      flash[:danger] = 'Nicht erlaubt!'
      redirect_to root_path
    end
  end

  def authenticate
    authenticate_or_request_with_http_basic('Administration') do |username, password|
      session[:admin] = (username == ENV['htaccess_login'] && password == ENV['htaccess_passwd'])
    end
  end
end
