class Share < ActiveRecord::Base
  belongs_to :groups
  has_many :offers, dependent: :destroy

  validates_length_of :name, minimum: 3, allow_blank: false
  validate :full_or_half

  def amount
    offers.last.amount if offers.last
  end

  def normalized_amount
    amount / size if amount
  end

  def full_or_half
    if !size || size % 0.5 != 0
      errors[:size] << 'muss durch 0.5 teilbar sein!'
    end
  end
end
