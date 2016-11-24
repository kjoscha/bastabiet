class Share < ActiveRecord::Base
  belongs_to :groups

  validates :name, presence: true, length: { minimum: 3 }
  validates :email, presence: true, length: { minimum: 3 }, uniqueness: true
  validate :full_or_half
  validate :group_not_full

  has_secure_password

  def group_not_full
    if size_of_all > 4
      errors[:size] << 'Bezugsgruppe ist voll!'
    end
  end

  def size_of_all
    Group.find(group_id).shares_count
  end

  def full_or_half
    if !size || size % 0.5 != 0
      errors[:size] << 'muss durch 0.5 teilbar sein!'
    end
  end

  def total_offer_minimum
    offer_minimum ? offer_minimum * size : 0
  end

  def total_offer_medium
    offer_medium ? offer_medium * size : 0
  end

  def total_offer_maximum
    offer_maximum ? offer_maximum * size : 0
  end

  def all_offers
    [offer_minimum, offer_medium, offer_maximum].compact
  end
end
