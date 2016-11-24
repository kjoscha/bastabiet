class Group < ActiveRecord::Base
  belongs_to :stations
  has_many :shares, dependent: :destroy  

  validates_length_of :name, minimum: 3, allow_blank: false

  def shares_count
    shares.map(&:size).sum
  end

  def completion
    shares_count / 4 * 100
  end

  def total_offer_minimum
    shares.map(&:total_offer_minimum).sum
  end

  def total_offer_medium
    shares.map(&:total_offer_medium).sum
  end

  def total_offer_maximum
    shares.map(&:total_offer_maximum).sum
  end
end
