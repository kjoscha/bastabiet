class MembersController < ApplicationController
  before_action :admin_or_current_share

  def create
    @share = Share.find(params[:share_id])
    @member = @share.members.build(member_params)
    flash[:danger] = @member.errors.full_messages.to_sentence unless @member.save
    redirect_to :back
  end

  def destroy
    @member = Member.find(params[:id])
    @member.destroy
    redirect_to :back
  end

  private

  def member_params
    params.require(:member).permit(:name, :email, :telephone)
  end
end