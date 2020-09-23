class GroupsController < ApplicationController
  before_filter :authenticate_admin

  def create
    @station = Station.find(params[:station_id])
    @group = @station.groups.build(group_params)
    flash[:danger] = @group.errors.full_messages.to_sentence unless @group.save
    redirect_to stations_path
  end

  def destroy
    @group = Group.find(params[:id])
    @group.destroy
    redirect_to stations_path
  end

  private

  def group_params
    params.require(:group).permit(:name)
  end
end
