class Station < ActiveRecord::Base
  has_many :groups, dependent: :destroy

  def amount
    sum = 0
    groups.each do |group|
      sum += group.amount
    end
    sum
  end
end
