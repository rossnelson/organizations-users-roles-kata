require 'rails_helper'

RSpec.describe User do

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

  it "should require a password" do
    user.password = ""
    expect(user).to be_invalid
  end

  describe "saving records" do
    it "should encrypt the password" do
      user.save

      expect user.crypted_password
      expect user.salt
    end
  end

  describe "updating records" do
    it "will allow a blank password" do
      user.save
      user.password = ""

      expect(user).to be_valid
    end

    it "the password will be updated" do
      user.save

      password = 'ross'
      user.update_attributes(password: password)
      crypted_password = BCrypt::Engine.hash_secret(password, user.salt)

      expect(user.crypted_password).to eq crypted_password
    end
  end

  #describe "#roles" do
    #it "should respond to roles"
    #it "should return an ActiveRecord::Association"
    #it "should contain at least one Role object"
  #end

end
