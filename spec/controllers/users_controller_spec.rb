require 'rails_helper'

describe UsersController, :type => :controller do
  describe "GET #show" do
    it "NOT LOGGED IN responds with success" do
      user = create(:user)
      get :show, :id => user.to_param, :format => :html
      expect(response).to be_success
    end
  end

  describe "GET #lookup" do
    it "responds with correct fuzzy search matches" do
      user1 = create(:user, name:"cosmicbob21")
      user2 = create(:user, name:"earthyalice")

      get :lookup, :query => "bob", :format => :json

      expect(response).to be_success
      assert_equal hash_from_json(response.body).first["sha"], user1.sha
      assert_equal hash_from_json(response.body).count, 1
    end
  end

end
