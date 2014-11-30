class User < ActiveRecord::Base
  has_secure_password

  validates :email, 
    presence: true, 
    uniqueness: true, 
    format: { with: /\A[^@\s]+@([^@\s]+\.)+[^@\s]+\z/ }
  validates :password, presence: true, on: :create

  has_many :roles, -> { includes(:org) }
  has_many :denied_orgs, -> { where(roles: {name: "Denied"}) },
    through: :roles,
    source: :org
  has_many :orgs, -> { where("roles.name != ?", "Denied") },
    through: :roles,
    source: :org

  def accessible_orgs
    orgs.map(&:self_and_descendants).flatten - denied_orgs
  end

  def accessible_org?(org)
    accessible_orgs.include?(org)
  end

end
