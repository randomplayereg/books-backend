class Book < ApplicationRecord
  belongs_to :user

  validates :title, presence: true
  validates :author, presence: true
  validates :user_id, presence: true

  mount_base64_uploader :picture, PictureUploader
end
