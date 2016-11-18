class Offer < ActiveRecord::Base
  belongs_to :share

  def the_amount
    amount ? amount : 0
  end
end
