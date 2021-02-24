class User < ApplicationRecord
  has_secure_password

  validates :name, presence: true
  validates :email, uniqueness: true, presence: true
  validates :password, presence: true
end
