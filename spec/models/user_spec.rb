require 'rails_helper'

RSpec.describe User do

  before :each do
    @user = FactoryGirl.build(:user)
  end

  it "should have a valid factory" do
    validity = @user.valid?

    expect(validity).to be true
  end

  it "is invalid without an email" do
    @user.email = nil
    validity    = @user.valid?

    expect(validity).to be false
  end

  it "requires a properly formated email" do
    @user.email = "ross_nelson"
    validity    = @user.valid?

    expect(validity).to be false
  end

  it "responds to password" do
    expect(@user).to respond_to 'password'
  end

  it "should require a password" do
    @user.password = ""
    validity = @user.save

    expect(validity).to be false
  end

  describe "updating records" do
    before :each do
      @user.save
      @id   = @user.id
      @user = User.find(@id)
    end

    it "will allow a blank password" do 
      validity = @user.save

      expect(@user.password).to be_blank
      expect(validity).to be true
    end
  end

  #describe "#roles" do
    #it "should respond to roles"
    #it "should return an ActiveRecord::Association"
    #it "should contain at least one Role object"
  #end

end
