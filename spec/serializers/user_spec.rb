require 'rails_helper'

RSpec.describe UserSerializer do

  let(:user) { create(:user, :with_roles_and_orgs) }

  context "attributes" do
    before :each do
      @serializer = described_class.new(user)
      @keys = @serializer.attributes.keys
    end

    it "has the expected keys" do
      expect(@keys).to eq [:id, :email, :created_at, :updated_at, :org_ids]
    end

    describe "#org_ids" do
      it "is an array of ids matching the users accessible orgs" do
        expect(@serializer.org_ids).to eq user.accessible_orgs.map(&:id)
      end
    end
  end

end



