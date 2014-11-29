require 'rails_helper'

RSpec.describe OrganizationSerializer do

  let(:organization) { create(:organization) }

  context "attributes" do
    it "has the expected keys" do
      keys = described_class.new(organization).attributes.keys
      expect(keys).to eq [:id, :name, :created_at, :updated_at, 
                          :descendants, :type]
    end
  end

end



