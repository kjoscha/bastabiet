class OffersController < ApplicationController
  def create
    @share = Share.find(params[:share_id])
    @offer = @share.offers.build(offer_params)
    flash[:danger] = @offer.errors.full_messages.to_sentence unless @offer.save
    redirect_to share_path(@share)
  end

  private

  def offer_params
    params.require(:offer).permit(:amount)
  end
end