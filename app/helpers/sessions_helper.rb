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

  def logged_in?
    !current_share.nil?
  end

  def admin_or_current_share
    if !((current_share && current_share.id == params[:id].to_i) || admin?)
      flash[:danger] = 'Nicht erlaubt!'
      redirect_to :root
    end
  end

  def authenticate
    authenticate_or_request_with_http_basic('Administration') do |username, password|
      session[:admin] = (username == 'admin' && password == 'secret')
    end
  end
end
