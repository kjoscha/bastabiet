class Statistic
  def initialize(offer)
    @offer = offer
  end

  attr_accessor :offer

  def total_share_size_with_offers
    shares_with_offer.map(&:size).sum
  end

  def shares
    Share.all.map(&:size).sum
  end

  def needed_monthly_average
    (needed_monthly_sum / Setting.first.total_shares).round(2)
  end

  def monthly_average
    (single_offers.inject{ |sum, el| sum + el }.to_f / single_offers.size).round(2)
  end

  def needed_monthly_sum
    (needed_sum.to_f / 12).round(2)
  end

  def monthly_sum
    offers.sum
  end

  def sum
    offers.sum * 12
  end

  def needed_sum
    Setting.first.needed_sum
  end


  def single_offers
    Share.all.map{ |share| share.send("one_#{offer}") }.compact
  end

  private

  def offers
    Share.all.map{ |share| share.send(offer) }.compact
  end

  def shares_with_offer
    Share.all.find_all do |share|
      share.send(offer)
    end
  end
end
