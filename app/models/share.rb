class Share < ActiveRecord::Base
  belongs_to :groups
  has_many :offers, dependent: :destroy

  validates :name, presence: true, length: { minimum: 3 }
  validates :email, presence: true, length: { minimum: 3 }, uniqueness: true
  validate :full_or_half

  has_secure_password

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
