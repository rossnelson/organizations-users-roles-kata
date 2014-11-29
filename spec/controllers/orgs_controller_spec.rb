require 'rails_helper'

RSpec.describe OrgsController, :type => :controller do

  describe "GET #index" do
    before :each do
      create :root_org_with_orgs
      get :index, format: :json
    end

    let(:body) { JSON.parse(response.body) }

    it "returns a 200 response" do
      expect(response.status).to eq 200
    end

    it "returns all orgs" do
      expect( body["orgs"].length ).to eq 13
    end
  end

end
