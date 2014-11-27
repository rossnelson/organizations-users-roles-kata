require 'rails_helper'

RSpec.describe RootOrg do
  let(:org) { build(:root_org) }

  it "should have a valid factory" do
    expect(org).to be_valid
  end

  it "should have_many organizations" do 
    association = RootOrg.reflect_on_association(:organizations)
    expect(association.macro).to eq :has_many
  end

  describe ".organizations" do
    let(:org) { build(:root_org_with_orgs) }

    it "should be a CollectionProxy of Organization objects" do
      child = org.organizations.shuffle.first

      expect(org.organizations).to_not be_blank
      expect(org).to_not be_an Organization
      expect(org.reload.organizations).to include child
    end
  end

  describe ".tree" do
    let(:org) { build(:root_org_with_orgs) }

    it "should be and array of organizations" do
      expect(org.tree).to be_an ActiveRecord::AssociationRelation
    end
    it "should eager load the organization's child_orgs" do
      expect(org.tree.first.association_cache.keys).to include :child_orgs
    end
  end

end


