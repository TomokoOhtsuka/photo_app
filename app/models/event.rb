class Event < ApplicationRecord
  belongs_to :hosts
  has_many :photos
  validates :title, {presence: true}
end
