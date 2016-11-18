class Statistic
  def offers
    Share.all.map { |s| s.normalized_amount }
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
    Share.all.map(&:amount).sum
  end
end
