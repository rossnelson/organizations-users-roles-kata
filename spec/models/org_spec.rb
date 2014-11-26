require 'rails_helper'

RSpec.describe Org do
  let(:org) { FactoryGirl.build(:org) }

  it "should have a valid factory" do
    expect(org).to be_valid
  end

  describe ".root" do
    it "responds to root" do
      expect org.root
    end
    it "should be an Org::Root"
  end

  describe ".children" do
    it "responds to children"
    it "should be an ActiveRecord::Association"
  end

end

