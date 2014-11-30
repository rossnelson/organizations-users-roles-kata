class OrgUser < User
  has_many :roles, -> { includes(:org) }, foreign_key: 'org_id'

  has_many :denied_orgs, -> { where(roles: {name: "Denied"}) },
    through: :roles,
    source: :org
  has_many :admin_orgs, -> { where(roles: {name: "Admin"}) },
    through: :roles,
    source: :org


  # The blog post didn't describe the difference in functionality related to
  # User and Admin roles. Typically I would ask for clarification, but for this I
  # decided to make a judgement call. 
  #
  # It would make sense that a user role would
  # allow access to only the related org, not the descendants.
  has_many :user_orgs, -> { where(roles: {name: "User"}) },
    through: :roles,
    source: :org

  def accessible_orgs
    (user_orgs + admin_orgs.map(&:self_and_descendants).flatten).uniq - denied_orgs
  end

  def accessible_org?(org)
    accessible_orgs.include?(org)
  end
end
