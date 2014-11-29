class RootOrgSerializer < OrgSerializer
  def descendants
    object.organizations.map do |child|
      OrganizationSerializer.new(child, scope: scope, root: false, event: object)
    end
  end
end
