class Group < ActiveRecord::Base
  belongs_to :stations
  has_many :shares, dependent: :destroy

  def amount
    sum = 0
    shares.each do |share|
      sum += share.offers.last.amount if share.offers.last
    end
    sum
  end
end
