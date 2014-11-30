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

end
