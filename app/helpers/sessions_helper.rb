module SessionsHelper
  # USER ####################
  def log_in(share)
    session[:share_id] = share.id
  end

  def log_out
    session.delete(:share_id)
    @current_share = nil
  end

  def current_share
    @current_share ||= Share.find_by(id: session[:share_id])
  end

  # ADMIN ####################
  def admin_log_in(admin)
    session[:admin_id] = admin.id
  end

  def admin_log_out
    session.delete(:admin_id)
    @current_admin = nil
  end

  def current_admin
    @current_admin ||= Admin.find_by(id: session[:admin_id])
  end

  # MISC ##################
  def authenticate_admin
    return false if current_admin
    redirect_to admin_path
  end

  def current_share?
    current_share && (current_share.id == params[:id].to_i || current_share.id == params[:share_id].to_i)
  end

  def admin_or_current_share
    unless (current_share && current_share?) || current_admin
      flash[:danger] = 'Nicht erlaubt!'
      redirect_to root_path
    end
  end
end
