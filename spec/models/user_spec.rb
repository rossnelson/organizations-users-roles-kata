require 'rails_helper'

RSpec.describe User do

  it "has a valid factory" do
    expect( build(:user) ).to be_valid
  end

  context "Validations" do
    describe "#email" do
      it "is required" do
        expect( build(:user, email: nil)).to be_invalid
      end

      it "must be properly formated" do
        expect( build(:user, email: "ross_nelson") ).to be_invalid
      end

      let(:existing_user) { create(:user) }

      it "must be a unique value" do
        expect( build(:user, email: existing_user.email) ).to be_invalid
      end
    end

    let(:user) { create(:user) }

    context "on new users" do
      describe "#password" do
        it "is required" do
          expect(build(:user, password: nil)).to be_invalid
        end

        it "is encrypted" do
          expect user.password_digest
        end
      end
    end

    context "on existing records" do
      describe "#password" do
        it "allows a blank password" do
          user.password = ""
          expect(user).to be_valid
        end
      end
    end
  end

  describe "#roles" do
    it "has many roles" do
      association = described_class.reflect_on_association(:roles)
      expect(association.macro).to eq :has_many
    end
  end

  let(:user) { create(:user, :with_roles_and_orgs) }

  describe "#orgs" do
    it "has many orgs" do
      association = described_class.reflect_on_association(:orgs)
      expect(association.macro).to eq :has_many
    end

    it "doesn't contain denied orgs" do
      role_ids_without_denied = user.roles
        .where('name != ?', "Denied")
        .map(&:org_id)
      org_ids = user.orgs.map(&:id)

      expect(role_ids_without_denied).to eq org_ids
    end
  end

  describe "#denied_orgs" do
    it "has many denied_orgs" do
      association = described_class.reflect_on_association(:denied_orgs)
      expect(association.macro).to eq :has_many
    end

    it "doesn't contain denied orgs" do
      role_ids_with_denied = user.roles
        .where('roles.name == ?', "Denied")
        .map(&:org_id)
      org_ids = user.denied_orgs.map(&:id)

      expect(role_ids_with_denied).to eq org_ids
    end
  end

  describe "#accessible_orgs" do
    it "returns all the accessible orgs and org descendants" do
      all_orgs        = user.orgs.map(&:self_and_descendants).flatten
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
      expect( user.accessible_org?(user.orgs.first) )
    end
  end

end
