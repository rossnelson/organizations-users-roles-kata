class User < ActiveRecord::Base
  has_secure_password

  validates :email, 
    presence: true, 
    format: { with: /\A[^@\s]+@([^@\s]+\.)+[^@\s]+\z/ }
  validates :password, presence: true, on: :create

  has_many :roles, -> { includes(:org) }
  has_many :orgs, -> { where("roles.name != ?", "Denied") },
    through: :roles,
    source: :org

end
