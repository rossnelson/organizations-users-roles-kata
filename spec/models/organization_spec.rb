require 'rails_helper'

RSpec.describe Organization do
  let(:organization) { build(:organization) }

  it "has a valid factory" do
    expect(build(:organization)).to be_valid
  end

  it "belongs to a root_org" do 
    association = Organization.reflect_on_association(:root_org)
    expect(association.macro).to eq :belongs_to
  end

  describe "#root" do
    it "is a RootOrg" do
      expect(build(:organization_with_root).root_org).to be_an RootOrg
    end
  end

  let(:organization) { create(:organization_with_children) }

  describe "#child_orgs" do
    it "is an array of ChildOrg objects" do
      expect(organization.child_orgs.map(&:class).uniq).to eq [ChildOrg]
      expect(organization.child_orgs).to_not be_blank
    end
    it "does not include the root org" do
      expect(organization.child_orgs).to_not include(organization.root_org)
    end
  end

  describe "#descendants" do
    it "is and array of related child orgs" do
      expect(organization.descendants.map(&:class).uniq).to eq [ChildOrg]
      expect(organization.descendants).to_not be_blank
    end
  end

  describe "#self_and_descendants" do
    it "is an array containing itself and it's descendants" do
      expect(organization.self_and_descendants.first).to be organization
      expect(
        organization.self_and_descendants.map(&:class).uniq
      ).to eq [Organization, ChildOrg]
    end
  end
end

