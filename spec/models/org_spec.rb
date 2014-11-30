require 'rails_helper'

RSpec.describe Org do
  context "Validations" do
    it "doesn't allow a blank name" do
      expect(build(:org, name: nil)).to be_invalid
    end

    let(:existing_org) { create(:org) }

    it "doesn't allow a duplicate name" do
      expect(build(:org, name: existing_org.name)).to be_invalid
    end
  end

  describe "#descendants" do
    it "is nil as a placeholder to be overridden in subclasses" do
      expect( build(:org).descendants ).to_not be
    end
  end

  describe "#self_and_descendants" do
    let(:org) { build(:org) }

    it "returns the org because it has no relationships" do
      expect( org.self_and_descendants ).to eq [org]
    end
  end
end
