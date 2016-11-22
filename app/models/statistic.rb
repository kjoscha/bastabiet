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

  def needed_average
    if Share.count > 0
      (20_000 / Share.count).round
    else
      0
    end
  end

  def needed_sum
    20_000
  end

  def sum
    Share.all.map(&:amount).compact.sum
  end
end
