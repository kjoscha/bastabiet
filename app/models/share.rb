class Share < ActiveRecord::Base
  belongs_to :groups
  has_many :offers, dependent: :destroy

  def amount
    offers.last ? offers.last.amount : 0
  end
end
