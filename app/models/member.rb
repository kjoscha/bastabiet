class Member < ActiveRecord::Base
  belongs_to :share
  has_one :station, through: :share
  has_one :group, through: :share

  validates :name, presence: true, length: { minimum: 3 }
  validates :email, presence: true, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i }
  validates_uniqueness_of :email
  validates :telephone, format: { with: /\A((?![a-zA-Z]).){3,20}\z/ }, if: 'telephone.present?'

  before_save :only_one_moneymaker

  def only_one_moneymaker
    if moneymaker
      siblings.each do |s|
        s.update(moneymaker: false)
      end
    end
  end

  def siblings
    share.members.where.not(id: id)
  end
end
