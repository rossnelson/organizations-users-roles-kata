class ChildOrg < Org
  belongs_to :organization, foreign_key: 'parent_id'
end
