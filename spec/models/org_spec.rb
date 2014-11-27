require 'rails_helper'

RSpec.describe Org do
  context "Validations" do
    it "should not allow a blank name" do
      expect(build(:org, name: nil)).to be_invalid
    end
  end
end
