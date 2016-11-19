class Station < ActiveRecord::Base
  has_many :groups, dependent: :destroy

  validates_length_of :name, minimum: 3, allow_blank: false

  def amount
    groups.map(&:amount).sum
  end
end
