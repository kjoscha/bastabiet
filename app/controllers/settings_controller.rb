class SettingsController < ApplicationController
  before_filter :authenticate_admin

  def update
    @settings = Setting.find(params[:id])
    flash[:danger] = @settings.errors.full_messages.to_sentence unless @settings.update(settings_params)
    redirect_to :back
  end

  private

  def settings_params
    params.require(:setting).permit(:needed_sum, :show_statistics, :offer_minimum_active, :offer_medium_active, :offer_maximum_active, :total_shares)
  end
end
