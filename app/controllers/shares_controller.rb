class SharesController < ApplicationController
  before_action :admin_or_current_share, except: [:new, :create]

  def admin_or_current_share
    if !((current_share && current_share.id == params[:id].to_i) || session[:authorized])
      flash[:danger] = 'Nicht erlaubt!'
      redirect_to :root
    end
  end

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
        redirect_to @share
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
    params.require(:share).permit(:name, :members, :size, :group_id, :email, :offer_minimum, :offer_medium, :offer_maximum, :password, :password_confirmation)
  end
end
