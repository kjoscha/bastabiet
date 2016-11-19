class Group < ActiveRecord::Base
  belongs_to :stations
  has_many :shares, dependent: :destroy

  def amount
    shares.map(&:amount).compact.sum
  end

  def shares_count
    shares.map(&:size).sum
  end
end
