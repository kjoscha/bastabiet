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
    (needed_sum / 145).round(2)
  end

  def needed_sum
    Setting.first.needed_sum
  end

  def sum
    offers.sum
  end
end
