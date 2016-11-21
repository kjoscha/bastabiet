class SharesController < ApplicationController
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
    flash[:danger] = @share.errors.full_messages.to_sentence unless @share.update_attributes(share_params)
    redirect_to :back
  end

  private

  def share_params
    params.require(:share).permit(:name, :members, :size, :group_id, :email, :password, :password_confirmation)
  end
end
