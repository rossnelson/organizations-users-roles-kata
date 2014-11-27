require 'rails_helper'

RSpec.describe Organization do
  let(:organization) { build(:organization) }

  it "should have a valid factory" do
    expect(build(:organization)).to be_valid
  end

  it "should belong to a root_org" do 
    association = Organization.reflect_on_association(:root_org)
    expect(association.macro).to eq :belongs_to
  end

  describe "#root" do
    it "should be an RootOrg" do
      expect(build(:organization_with_root).root_org).to be_an RootOrg
    end
  end

  describe "#children" do
    let(:organization) { create(:organization_with_children) }

    it "should be a collection of Org::Child objects" do
      child = ChildOrg.order("RANDOM()").find_by(parent_id: organization.id)

      expect(organization.child_orgs).to_not be_blank
      expect(child).to be_an ChildOrg
      expect(organization.child_orgs).to include child
    end
  end

end

