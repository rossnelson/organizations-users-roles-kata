require 'rails_helper'

RSpec.describe Role do

  context "Validations" do

    describe ".name" do
      it "should not be blank" do
        expect( build(:role, name: nil) ).to be_invalid
      end

      let(:role) { build(:role, name: 'SuperAdmin') }

      it "should be a valid option" do
        expect(role).to be_invalid
        expect(role.errors.messages.keys).to include :name
      end

      it "should be unique within its peers" do
        create(:role, :admin)
        expect(build(:role, :admin)).to be_invalid
      end

    end

  end
end
