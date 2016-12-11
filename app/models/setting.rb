class Setting < ActiveRecord::Base
  validates :needed_sum,
    presence: true,
    numericality: true
  validates :total_shares,
    presence: true,
    numericality: { only_integer: true }

  def self.add_default
    Setting.create(
      needed_sum: 15_000,
      total_shares: 145,
    )
  end
end
