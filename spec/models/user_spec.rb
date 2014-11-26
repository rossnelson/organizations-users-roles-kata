require 'rails_helper'

RSpec.describe User do
  describe "Validations" do
    let(:user) { FactoryGirl.build(:user) }

    it "should have a valid factory" do
      expect(user).to be_valid
    end

    it "is invalid without an email" do
      user.email = nil
      expect(user).to be_invalid
    end

    it "requires a properly formated email" do
      user.email = "ross_nelson"
      expect(user).to be_invalid
    end

    context "on new users" do
      let(:user) { FactoryGirl.build(:user) }

      it "should require a password" do
        user.password = nil
        expect(user).to be_invalid
      end

      it "should encrypt the password" do
        user.save
        expect user.password_digest
      end
    end

    context "on existing records" do
      it "will allow a blank password" do
        user.save
        user.password = ""

        expect(user).to be_valid
      end
    end
  end

  #describe "#roles" do
    #it "should respond to roles"
    #it "should return an ActiveRecord::Association"
    #it "should contain at least one Role object"
  #end

end
