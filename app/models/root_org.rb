class RootOrg < Org
  has_many :organizations, foreign_key: 'parent_id'

  def tree
    organizations.eager_load(:child_orgs)
  end
end
