class User < ActiveRecord::Base
  has_secure_password

  validates :email, 
    presence: true, 
    format: { with: /\A[^@\s]+@([^@\s]+\.)+[^@\s]+\z/ }
  validates :password, presence: true, on: :create

  has_many :roles
end
