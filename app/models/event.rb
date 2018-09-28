class Event < ApplicationRecord
  belongs_to :host
  has_many :photos
  validates :title, {presence: true}
end
