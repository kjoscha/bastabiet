module SessionsHelper
  def log_in(share)
    session[:share_id] = share.id
  end

  def current_share
    @current_share ||= Share.find_by(id: session[:share_id])
  end

  def logged_in?
    !current_share.nil?
  end
end
