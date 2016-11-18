class Statistic
  def offers
    Share.all.map { |s| s.amount }
  end

  def average
    offers.inject{ |sum, el| sum + el }.to_f / offers.size
  end

  def needed_average
    20_000 / Share.count
  end
end
