class Upload < ActiveRecord::Base
  mount_uploader :file, FileUploader

  validates :name, presence: true, uniqueness: true
  validates :description, presence: true
  validates :file, presence: true
end
