class User < ActiveRecord::Base
  attr_accessor :password

  validates :email, 
    presence: true, 
    format: { with: /\A[^@\s]+@([^@\s]+\.)+[^@\s]+\z/ }
  validates :password, presence: true, on: :create

  before_save :encrypt_password

  def encrypt_password
    if password.present?
      self.salt             = BCrypt::Engine.generate_salt
      self.crypted_password = BCrypt::Engine.hash_secret(password, salt)
    end
  end
end
