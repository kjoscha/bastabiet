class GroupsController < ApplicationController
  def create
    @station = Station.find(params[:station_id])
    @group = @station.groups.build(group_params)
    flash[:danger] = @group.errors.full_messages.to_sentence unless @group.save
    redirect_to station_path(@station)
  end

  def show
    @group = Group.find(params[:id])
    @shares = @group.shares
  end

  private

  def group_params
    params.require(:group).permit(:name)
  end
end