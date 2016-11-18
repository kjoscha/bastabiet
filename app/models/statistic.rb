class Statistic
  def offers
    Share.all.map { |s| s.amount }
  end

  def average
    offers.inject{ |sum, el| sum + el }.to_f / offers.size
  end

  def needed_average
    if Share.count > 0
      20_000 / Share.count
    else
      0
    end
  end
end
