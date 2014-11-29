require 'rails_helper'

RSpec.describe ChildOrgSerializer do

  let(:child_org) { create(:child_org, :with_organization) }

  context "attributes" do
    it "has the expected keys" do
      keys = described_class.new(child_org).attributes.keys
      expect(keys).to eq [:id, :name, :created_at, :updated_at, 
                          :descendants, :type]
    end
  end

end

