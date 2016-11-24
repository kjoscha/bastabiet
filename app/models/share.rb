class Share < ActiveRecord::Base
  belongs_to :groups

  validates :name, presence: true, length: { minimum: 3 }
  validates :email, presence: true, length: { minimum: 3 }, uniqueness: true
  validate :full_or_half
  validate :group_not_full

  has_secure_password

  def group_not_full
    if size_of_other_group_shares + size > 4
      errors[:size] << 'Bezugsgruppe ist voll!'
    end
  end

  def size_of_other_group_shares
    other_group_shares.map(&:size).sum
  end 

  def other_group_shares
    group.shares.where.not(id: id)
  end

  def group
    Group.find(group_id)
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
