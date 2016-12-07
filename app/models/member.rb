class Member < ActiveRecord::Base
  belongs_to :shares

  validates :name, presence: true, length: { minimum: 3 }
  validates :email, presence: true, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i }
  validates_uniqueness_of :email
  validate :name_at_least_two_words?

  def name_at_least_two_words?
    if name.split.size < 2
      errors[:base] << 'Bitte gib  Vor- und Nachnamen an'
    end
  end
end
