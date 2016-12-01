class SharesController < ApplicationController
  before_action :admin_or_current_share, only: [:edit, :update, :destroy]
  before_action :is_activated?, only: [:update]

  def new
    @groups = Group.all
    @group_selection = @groups.map{ |g| [g.name, g.id] }
    @share = Share.new
  end

  def create
    @groups = Group.all
    if share_params[:group_id] == ''
      flash[:danger] = 'Gruppe wählen!'
      redirect_to :register
    else
      @group = Group.find(share_params[:group_id])
      @group_selection = @groups.map{ |g| [g.name, g.id] }
      @share = @group.shares.build(share_params)
      if @share.save
        MessageMailer.activation_link(@share).deliver_now
        flash[:success] = "Der Account wurde erfolgreich angelegt, muss aber noch aktiviert werden. Folge dazu einfach dem Link in der Aktivierungs-Email, die wir dir soeben zugesandt haben!"
        redirect_to root_url
      else
        flash[:danger] = @share.errors.full_messages.to_sentence
        render :new
      end
    end
  end

  def show
    @share = Share.find(params[:id])
  end

  def update
    @share = Share.find(params[:id])
    if @share.update_attributes(share_params) && fill_offers(@share)
      flash[:success] = 'Erfolgreich aktualisiert'
      redirect_to :back
    else
      flash[:danger] = @share.errors.full_messages.to_sentence
      redirect_to :back
    end
  end

  def destroy
    @share = Share.find(params[:id])
    @share.destroy
    redirect_to :back
  end

  def current_shares_home
    if logged_in?
      redirect_to share_path(current_share)
    else
      redirect_to login_path
    end
  end

  private

  def fill_offers(share)
    all_offers = share.all_offers
    @share.update_attributes!(
      offer_minimum:  all_offers[0] || all_offers[1] || all_offers[2],
      offer_medium:   all_offers[1] || all_offers[0] || all_offers[2],
      offer_maximum:  all_offers[2] || all_offers[1] || all_offers[0],
    )
  end

  def share_params
    params.require(:share).permit(:name, :size, :group_id, :email, :offer_minimum, :offer_medium, :offer_maximum, :password, :password_confirmation, :feedback, :land_help_days, :no_help, :workgroup, :skills, :payment, :agreed)
  end

  def is_activated?
    unless Share.find(params[:id]).activated    
      flash[:danger] = "Dieser Anteil wurde noch nicht aktiviert!"
      redirect_to root_url
    end
  end
end
