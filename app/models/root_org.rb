class RootOrg < Org
  has_many :organizations, -> { eager_load(:child_orgs) },
    foreign_key: 'parent_id'

  def descendants
    organizations.map(&:self_and_descendants).flatten
  end
end
