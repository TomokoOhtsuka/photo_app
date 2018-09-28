class Photo < ApplicationRecord
  belongs_to :event
  default_scope -> { order(created_at: :desc) }
  mount_uploader :picture, PictureUploader
  validates :photo, { presence: true }
end