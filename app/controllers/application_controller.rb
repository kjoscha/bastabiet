class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_filter :save_offers_array

  include SessionsHelper

  def save_offers_array
    @offers_minimum = Statistic.new('offer_minimum')
    @offers_medium = Statistic.new('offer_medium')
    @offers_maximum = Statistic.new('offer_maximum')
  end
end
