class Share < ActiveRecord::Base
  belongs_to :groups

  attr_accessor :activation_token

  before_create :create_activation_digest

  validates :name, presence: true, length: { minimum: 3 }
  validates :email, presence: true, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i }
  validates_uniqueness_of :name
  validates_uniqueness_of :email
  validate :name_at_least_two_words?
  validate :group_not_full?
  validate :agreed?
  validate :permitted_size?

  has_secure_password

  def name_at_least_two_words?
    if name.split.size < 2
      errors[:base] << 'BItte gib deinen Vor- und Nachnamen an'
    end
  end

  def group_not_full?
    if size_of_other_group_shares + (size || 0) > 4
      errors[:base] << 'Bezugsgruppe ist voll!'
    end
  end

  def permitted_size?
    if !size_selections.include? size
      errors[:base] << 'Nur halbe und ganze Ernteanteile erlaubt'
    end
  end

  def agreed?
    errors[:base] << 'Bitte lies und bestätige die Vereinbarung' if !agreed
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

  def size_selections
    [0.5, 1.0, 1.5, 2.0, 2.5, 3.0, 3.5, 4.0]
  end

  def self.size_altogether
    all.map(&:size).sum
  end
end
