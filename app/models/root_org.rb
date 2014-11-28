class RootOrg < Org
  has_many :organizations, -> { eager_load(:child_orgs) },
    foreign_key: 'parent_id'

  def descendants
    organizations.to_a.concat(
      organizations.map(&:child_orgs)
    ).flatten
  end
end
