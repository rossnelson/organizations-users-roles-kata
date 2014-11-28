require 'rails_helper'

RSpec.describe RootOrg do

  it "has a valid factory" do
    expect(build(:root_org)).to be_valid
  end

  it "has many organizations" do 
    association = RootOrg.reflect_on_association(:organizations)
    expect(association.macro).to eq :has_many
  end

  let(:org) { build(:root_org_with_orgs) }

  describe "#organizations" do
    it "is an array of Organizations" do
      expect(org.organizations.map(&:class).uniq).to eq [Organization]
    end

    it "eager loads the organization's child_orgs" do
      expect(org.organizations.first.association_cache.keys).to include :child_orgs
    end
  end

  describe "#descendants" do
    it "is an array of the organizations and child_orgs" do
      expect(org.descendants.map(&:class).uniq).to eq [Organization, ChildOrg]
    end
  end

  describe "#self_and_descendants" do
    it "is an array containing itself and it's descendants" do
      expect(org.self_and_descendants.first).to be org
      expect(
        org.self_and_descendants.map(&:class).uniq
      ).to eq [RootOrg, Organization, ChildOrg]
    end
  end
end
