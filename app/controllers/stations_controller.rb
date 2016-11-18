class StationsController < ApplicationController
  def index
    @stations = Station.all
    @station = Station.new
  end

  def create
    @station = Station.new(station_params)
    flash[:danger] = @station.errors.full_messages.to_sentence unless @station.save
    redirect_to stations_path
  end

  def show
    @station = Station.find(params[:id])
    @groups = @station.groups
  end

  private

  def station_params
    params.require(:station).permit(:name)
  end
end
