class Event < ApplicationRecord
  belongs_to :host
  has_many :photos
  validates :title, {presence: true}
  validates :guest_password, {presence: true, length: {mininum: 6, maximum: 20}}
end
