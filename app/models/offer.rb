class Offer < ActiveRecord::Base
  belongs_to :share

  validates :amount, numericality: { only_integer: true, greater_than_or_equal_to: 1 }
end
