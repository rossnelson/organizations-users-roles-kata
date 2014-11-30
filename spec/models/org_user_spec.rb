require 'rails_helper'

RSpec.describe OrgUser do

  let(:user) { create(:org_user, :with_roles_and_orgs) }

  describe "#roles" do
    it "has many roles" do
      association = described_class.reflect_on_association(:roles)
      expect(association.macro).to eq :has_many
    end
  end

  describe "#admin_orgs" do
    it "has many orgs" do
      association = described_class.reflect_on_association(:admin_orgs)
      expect(association.macro).to eq :has_many
    end

    it "only contains orgs with Admin access" do
      admin_role_ids = user.roles
        .where('name == ?', "Admin")
        .map(&:org_id)

      expect(user.admin_orgs.map(&:id)).to eq admin_role_ids
    end
  end

  describe "#user_orgs" do
    it "has many orgs" do
      association = described_class.reflect_on_association(:user_orgs)
      expect(association.macro).to eq :has_many
    end

    it "only contains orgs with User access" do
      user_role_ids = user.roles
        .where('name == ?', "User")
        .map(&:org_id)

      expect(user.user_orgs.map(&:id)).to eq user_role_ids
    end
  end

  describe "#denied_orgs" do
    it "has many denied_orgs" do
      association = described_class.reflect_on_association(:denied_orgs)
      expect(association.macro).to eq :has_many
    end

    it "only contains denied orgs" do
      role_ids_with_denied = user.roles
        .where('roles.name == ?', "Denied")
        .map(&:org_id)
      org_ids = user.denied_orgs.map(&:id)

      expect(role_ids_with_denied).to eq org_ids
    end
  end

  describe "#accessible_orgs" do
    it "returns all the accessible orgs and org descendants" do
      all_orgs        = (user.user_orgs + user.admin_orgs
                         .map(&:self_and_descendants)).flatten
      accessible_orgs = all_orgs - user.denied_orgs

      expect(user.accessible_orgs).to eq accessible_orgs
    end

    it "does not contain any denied descendants" do
      denied_ids = user.roles.where(name: 'Denied').map(&:org_id)
      expect(denied_ids & user.accessible_orgs.map(&:id)).to eq []
    end
  end

  describe "#accessible_org?" do
    it "is true if the org is within the accessible orgs" do
      expect( !user.accessible_org?(user.denied_orgs.first) )
      expect( user.accessible_org?(user.user_orgs.first) )
    end
  end
end
