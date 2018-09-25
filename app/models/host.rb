class Host < ApplicationRecord
  has_secure_password
  validates :name, {presence: true}
  validates :email, {presence: true, uniqueness: true}
  validates :password, {length: {minimum: 6}}
  validates :password_digest, {length: {minimum: 6}}
  has_many :events
end
