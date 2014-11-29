class UserSerializer < ActiveModel::Serializer

  attributes :id, :email, :created_at, :updated_at, :org_ids

  def org_ids
    object.accessible_orgs.map(&:id)
  end

end
