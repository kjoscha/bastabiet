class StationsController < ApplicationController
  http_basic_authenticate_with name: 'admin', password: 'secret'

  def index
    @stations = Station.all
    @station = Station.new
    session[:authorized] = true
  end

  def create
    @station = Station.new(station_params)
    flash[:danger] = @station.errors.full_messages.to_sentence unless @station.save
    redirect_to stations_path
  end

  def destroy
    @station = Station.find(params[:id])
    @station.destroy
    redirect_to stations_path
  end

  private

  def station_params
    params.require(:station).permit(:name)
  end
end
