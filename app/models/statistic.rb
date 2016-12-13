class Statistic
  def initialize(offer)
    @offer = offer
  end

  attr_accessor :offer

  def offers
    Share.all.map{ |share| share.send(offer) }.compact
  end

  def shares_with_offer
    Share.all.find_all do |share|
      share.send(offer)
    end
  end

  def total_share_size_with_offers
    shares_with_offer.map(&:size).sum
  end

  def average
    (single_offers.inject{ |sum, el| sum + el }.to_f / single_offers.size).round(2)
  end

  def shares
    Share.all.map(&:size).sum
  end

  def needed_average
    (needed_sum / Setting.first.total_shares).round(2)
  end

  def needed_sum
    Setting.first.needed_sum.to_f / 12
  end

  def single_offers
    Share.all.map{ |share| share.send("one_#{offer}") }.compact
  end

  def sum
    offers.sum
  end
end
