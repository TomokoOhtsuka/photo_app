class Host < ApplicationRecord
  has_secure_password
  validates :name, {presence: true}
  validates :email, {presence: true, uniqueness: true}
  validates :password_digest, {length: {minimum: 6}}
  
end
