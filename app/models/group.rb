class Group < ActiveRecord::Base
  belongs_to :stations
  has_many :shares, dependent: :destroy
end
