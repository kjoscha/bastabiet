class Station < ActiveRecord::Base
  has_many :groups, dependent: :destroy
end
