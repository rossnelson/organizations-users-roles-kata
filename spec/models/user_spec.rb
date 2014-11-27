require 'rails_helper'

RSpec.describe User do

  it "should have a valid factory" do
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
    end

    let(:user) { create(:user) }

    context "on new users" do
      describe "#password" do
        it "should be required" do
          expect(build(:user, password: nil)).to be_invalid
        end

        it "should be encrypted" do
          expect user.password_digest
        end
      end
    end

    context "on existing records" do
      describe "#password" do
        it "will allow a blank password" do
          user.password = ""
          expect(user).to be_valid
        end
      end
    end
  end

  describe "#roles" do
    it "should have_many roles" do
      association = User.reflect_on_association(:roles)
      expect(association.macro).to eq :has_many
    end
  end

  let(:user_tree) { create(:user, :with_roles_and_orgs) }

  describe "#orgs" do
    it "should have_many orgs" do
      association = User.reflect_on_association(:orgs)
      expect(association.macro).to eq :has_many
    end

    it "should not have any denied orgs" do
      role_ids_without_denied = user_tree.roles
        .where('name != ?', "Denied")
        .map(&:org_id)
      org_ids = user_tree.orgs.map(&:id)

      expect(role_ids_without_denied).to eq org_ids
    end
  end

  describe "#access_level_for_org" do
    context "given an org it determines a user's access" do
      #it "should return false when the role is Denied"
      #it "should return false when there is no role"
      #it "should return true when there is a role of User or Admin"
      #it "should return true when there is a role of Admin for any of it's parents"
    end
  end

end
