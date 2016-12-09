class Station < ActiveRecord::Base
  has_many :groups, dependent: :destroy

  validates :name, uniqueness: true
end
