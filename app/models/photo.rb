class Photo < ApplicationRecord
  belongs_to :event
  default_scope -> { order(created_at: :desc) }
  mount_uploader :image, PictureUploader
  validates :image, { presence: true }
end