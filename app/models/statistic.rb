class Statistic
  def initialize(offer)
    @offer = offer
  end

  attr_accessor :offer

  def offers
    Share.all.map{ |share| share.send(offer) }.compact
  end

  def average
    (offers.inject{ |sum, el| sum + el }.to_f / offers.size).round(2)
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

  def total_offers
    Share.all.map{ |share| share.send("total_#{offer}") }.compact
  end

  def sum
    total_offers.sum
  end
end
