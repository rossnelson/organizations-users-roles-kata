class OrganizationSerializer < OrgSerializer

  def descendants
    object.child_orgs.map do |child|
      ChildOrgSerializer.new(child, scope: scope, root: false, event: object)
    end
  end

end

