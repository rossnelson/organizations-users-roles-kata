require 'rails_helper'

RSpec.describe RootOrgSerializer do

  let(:root_org) { create(:root_org) }

  context "attributes" do
    it "has the expected keys" do
      keys = described_class.new(root_org).attributes.keys
      expect(keys).to eq [:id, :name, :created_at, :updated_at, 
                          :descendants, :type]
    end
  end

end


