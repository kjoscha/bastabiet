class Statistic
  def initialize(offer)
    @offer = offer
  end

  attr_accessor :offer

  def offers
    Share.all.map{ |share| share.send(offer) }.compact
  end

  def offers_count
    offers.size
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
    Setting.first.needed_sum
  end

  def single_offers
    Share.all.map{ |share| share.send("one_#{offer}") }.compact
  end

  def sum
    offers.sum
  end
end
