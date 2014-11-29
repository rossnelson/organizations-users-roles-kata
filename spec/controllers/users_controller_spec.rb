require 'rails_helper'

RSpec.describe UsersController, :type => :controller do
  describe "GET #index" do
    before :each do
      3.times { create :user }
      get :index, format: :json
    end

    let(:body) { JSON.parse(response.body) }

    it "returns a 200 response" do
      expect(response.status).to eq 200
    end

    it "returns all users" do
      expect( body["users"].length ).to eq 3
    end
  end

  let(:user) { create(:user, :with_roles_and_orgs) }

  describe "GET #show" do
    before :each do
      get :show, id: user.id, format: :json
    end

    let(:body) { JSON.parse(response.body) }

    it "returns a 200 response" do
      expect(response.status).to eq 200
    end

    it "returns a requested user by id" do
      expect(body["user"]["email"]).to eq user.email
    end

    it "does not include the password_digest" do
      expect( body["user"].keys ).to_not include "password_digest"
    end
  end
end
