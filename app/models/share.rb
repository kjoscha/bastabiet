class Share < ActiveRecord::Base
  belongs_to :group
  has_one :station, through: :group
  has_many :members, dependent: :destroy
  has_many :workgroup_shares, dependent: :destroy
  has_many :workgroups, through: :workgroup_shares

  attr_accessor :activation_token, :password_reset_token

  before_create do
    create_digest_for(attribute: 'activation')
  end

  after_create do
    MessageMailer.admin_notification_creation(self).deliver_now
  end

  after_update do
    MessageMailer.admin_notification_change(self, self.previous_changes).deliver_now
  end

  after_destroy do
    MessageMailer.admin_notification_deletion(self).deliver_now
  end

  validates :name,
    presence: true,
    length: { minimum: 3 },
    uniqueness: true
  validates :email,
    presence: true,
    format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i },
    uniqueness: true
  validates :telephone,
    format: { with: /\A((?![a-zA-Z]).){3,20}\z/ }, if: 'telephone.present?'
  validates :payment, presence: true, on: :update, if: :form_edit?
  validates :size, presence: true

  validate :name_at_least_two_words?
  validate :group_not_full?
  validate :agreed?, on: :update, if: :form_edit?
  validate :group_not_full?
  validate :permitted_size?

  has_secure_password

  def name_at_least_two_words?
    if name.split.size < 2
      errors[:base] << 'Bitte gib deinen Vor- und Nachnamen an'
    end
  end

  def group_not_full?
    if size_of_siblings + (size || 0) > 4
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

  def form_edit?
    @form_edit
  end

  def form_edit
    @form_edit = true
  end

  def size_of_siblings
    siblings.map(&:size).sum
  end

  def siblings
    group.shares.where.not(id: id)
  end

  def station
    Station.find(group.station_id)
  end

  def group
    Group.find(group_id)
  end

  def one_offer_minimum
    offer_minimum / size if offer_minimum
  end

  def one_offer_medium
    offer_medium / size if offer_medium
  end

  def one_offer_maximum
    offer_maximum / size if offer_maximum
  end

  def all_offers
    [offer_minimum, offer_medium, offer_maximum].compact
  end

  def authenticated?(attribute:, token:)
    return false unless digest = self.send("#{attribute}_digest")
    BCrypt::Password.new(digest).is_password?(token)
  end

  def create_digest_for(attribute:)
    token = SecureRandom.urlsafe_base64(24)
    cost = Rails.env == "production" ? BCrypt::Engine::MAX_SALT_LENGTH : 4
    digest = BCrypt::Password.create(token, cost: cost)

    self.send("#{attribute}_token=", token)
    self.send("#{attribute}_digest=", digest)
    self.send("#{attribute}_timestamp=", Time.now)
  end

  def size_selections
    [0.5, 1.0, 1.5, 2.0, 2.5, 3.0, 3.5, 4.0]
  end

  def self.size_altogether
    all.map(&:size).sum
  end

  def create_password_reset_digest
    self.password_reset_token = SecureRandom.urlsafe_base64(24)
    self.password_reset_digest = Share.digest(token: password_reset_token)
    self.password_reset_timestamp = Time.now
  end

  def password_reset_token_alive?
    return false unless password_reset_timestamp
    (Time.now - password_reset_timestamp)/3600 < 24
  end
end
