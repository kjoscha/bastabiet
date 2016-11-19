class Share < ActiveRecord::Base
  belongs_to :groups
  has_many :offers, dependent: :destroy

  def amount
    offers.last.amount if offers.last
  end

  def normalized_amount
    amount / size if amount
  end
end
