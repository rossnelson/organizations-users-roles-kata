class OrgSerializer < ActiveModel::Serializer
  attributes :id, :name, :created_at, :updated_at, :descendants, :type
end
