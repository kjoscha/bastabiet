class Group < ActiveRecord::Base
  belongs_to :stations
  has_many :shares, dependent: :destroy

  def amount
    sum = 0
    shares.each do |share|
      sum += share.amount
    end
    sum
  end
end
