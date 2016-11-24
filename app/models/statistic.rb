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
    needed_sum / Group.count * 10 if Group.count > 0
  end

  def needed_sum
    20_000
  end

  def sum
    offers.sum
  end
end
