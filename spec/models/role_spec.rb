require 'rails_helper'

RSpec.describe Role do

  context "Validations" do
    let(:role) { build(:role, :admin) }

    describe ".name" do
      it "should not be blank" do
        expect( build(:role, name: nil) ).to be_invalid
      end

      it "should be a valid option" do
        role.name = "SuperAdmin"
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
