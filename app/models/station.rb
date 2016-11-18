class Station < ActiveRecord::Base
  has_many :groups, dependent: :destroy

  def amount
    sum = 0
    groups.each do |group|
      group.shares.each do |share|
        sum += share.amount
      end
    end
    sum
  end
end
