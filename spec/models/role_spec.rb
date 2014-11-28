require 'rails_helper'

RSpec.describe Role do
  context "Validations" do
    describe "#name" do
      it "can not be blank" do
        expect( build(:role, name: nil) ).to be_invalid
      end

      let(:role) { build(:role, name: 'SuperAdmin') }

      it "is invalid with an unsupported value" do
        expect(role).to be_invalid
        expect(role.errors.messages.keys).to include :name
      end

      it "allows only unique values within its peers" do
        create(:role, :admin)
        expect(build(:role, :admin)).to be_invalid
      end
    end
  end

  context "Associations" do
    it "belongs to a user" do
      association = described_class.reflect_on_association(:user)
      expect(association.macro).to eq :belongs_to
    end

    it "belongs to a org" do
      association = described_class.reflect_on_association(:org)
      expect(association.macro).to eq :belongs_to
    end
  end
end
