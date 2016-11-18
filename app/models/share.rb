class Share < ActiveRecord::Base
  belongs_to :groups
  has_many :offers, dependent: :destroy
end
