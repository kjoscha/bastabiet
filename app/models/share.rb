class Share < ActiveRecord::Base
  belongs_to :groups
  has_many :offers, dependent: :destroy

  def amount
    offers.last ? offers.last.the_amount : 0
  end

  def normalized_amount
    amount / size
  end
end
