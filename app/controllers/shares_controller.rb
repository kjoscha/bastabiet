class SharesController < ApplicationController
  def create
    @group = Group.find(params[:group_id])
    @share = @group.shares.build(share_params)
    flash[:danger] = @share.errors.full_messages.to_sentence unless @share.save
    redirect_to group_path(@group)
  end

  def show
    @share = Share.find(params[:id])
  end

  private

  def share_params
    params.require(:share).permit(:name, members: [])
  end
end
