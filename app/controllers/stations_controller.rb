class StationsController < ApplicationController
  before_filter :authenticate

  def index
    @stations = Station.all
    @station = Station.new

		@shares = Share.all
    @members = Member.all
    @workgroups = Workgroup.all

    respond_to do |format|
      format.html
      format.xls { headers["Content-Disposition"] = "attachment; filename=\"basta_bietverfahren - #{Date.today.to_s}.xls\"" }
    end
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
