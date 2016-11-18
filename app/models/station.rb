class Station < ActiveRecord::Base
  has_many :groups, dependent: :destroy

  def amount
    groups.map(&:amount).sum
  end
end
