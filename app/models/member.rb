class Member < ActiveRecord::Base
  belongs_to :share
  has_one :station, through: :share
  has_one :group, through: :share

  validates :name, presence: true, length: { minimum: 3 }
  validates :email, presence: true, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i }
  validates_uniqueness_of :email
  validates :telephone, format: { with: /\A((?![a-zA-Z]).){3,20}\z/ }, if: 'telephone.present?'
  validate :name_at_least_two_words?

  def name_at_least_two_words?
    if name.split.size < 2
      errors[:base] << 'Bitte gib  Vor- und Nachnamen an'
    end
  end
end
