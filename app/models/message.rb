class Message
  include ActiveModel::Model
  include ActiveModel::Validations
  include ActiveModel::Conversion

  attr_accessor :name, :email, :subject, :text

  validates :name, presence: true
  validates :email, presence: true
  validates :subject, presence: true
  validates :text, presence: true
end
