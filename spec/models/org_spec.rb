require 'rails_helper'

RSpec.describe Org do
  
  let(:org) { build(:org) }

  context "Validations" do
    it "should not allow a blank name" do
      org.assign_attributes(name: nil)
      expect(org).to be_invalid
    end
  end

end
