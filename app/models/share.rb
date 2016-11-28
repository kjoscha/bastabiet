class Share < ActiveRecord::Base
  belongs_to :groups

  attr_accessor :activation_token

  before_create :create_activation_digest

  validates :name, presence: true, length: { minimum: 3 }
  validates :email, presence: true, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i }

  validate :full_or_half
  validate :group_not_full
  validate :agreed?
  validates :size, inclusion: { in: [0.5, 1, 1.5, 2, 2.5, 3, 3.5, 4], message: "%{value} is not a valid size" }

  has_secure_password

  def group_not_full
    if size_of_other_group_shares + (size || 0) > 4
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

  def agreed?
    errors[:agreed] << 'Bitte lies bestätige die Vereinbarung!' if !agreed
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

  def self.digest(token:)
    cost = Rails.env == "production" ? BCrypt::Engine::MAX_SALT_LENGTH : 10
    BCrypt::Password.create(token, cost: cost)
  end

  def create_activation_digest
    self.activation_token = SecureRandom.urlsafe_base64(24)
    self.activation_digest = Share.digest(token: activation_token)
  end
end
