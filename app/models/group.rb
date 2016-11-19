class Group < ActiveRecord::Base
  belongs_to :stations
  has_many :shares, dependent: :destroy

  validates_length_of :name, minimum: 3, allow_blank: false

  def amount
    shares.map(&:amount).compact.sum
  end

  def shares_count
    shares.map(&:size).sum
  end
end
