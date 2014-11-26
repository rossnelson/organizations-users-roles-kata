class User < ActiveRecord::Base
  attr_accessor :password

  validates :email, 
    presence: true, 
    format: { with: /\A[^@\s]+@([^@\s]+\.)+[^@\s]+\z/ }

  validates :password, presence: true, on: :create
end
