require 'rails_helper'

RSpec.describe ChildOrg do

  let(:child_org) { create(:child_org, :with_organization) }

  describe "organization" do
    it "is an Organization object" do
      expect(child_org.organization.class).to eq Organization
      expect(child_org.organization).to_not be_blank
    end
  end

  describe "#descendants" do
    it "has no descendants and returns nil" do
      expect( child_org.descendants ).to_not be
    end
  end

  describe "#self_and_descendants" do
    it "returns the org because it has no descendants" do
      expect( child_org.self_and_descendants ).to eq [child_org]
    end
  end

end
