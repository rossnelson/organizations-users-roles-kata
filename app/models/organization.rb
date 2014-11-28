class Organization < Org
  belongs_to :root_org, foreign_key: 'parent_id'
  has_many :child_orgs, foreign_key: 'parent_id'

  def descendants
    child_orgs
  end
end
