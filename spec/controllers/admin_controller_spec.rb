require 'rails_helper'

describe AdminController, :type => :controller do
  describe "GET #index" do
    it "NOT LOGGED IN responds with a redirect" do
      get :index, :format => :html
      expect(response).to be_redirect
    end
  end

  describe "GET #index as non-admin" do
    it "LOGGED IN responds with a redirect" do
      user = create(:user)
      allow(controller).to receive_message_chain(:current_user).and_return(user)

      get :index, :format => :html
      expect(response).to be_redirect
    end
  end

  describe "GET #index as admin" do
    it "LOGGED IN responds with a redirect" do
      user = create(:admin_user)
      allow(controller).to receive_message_chain(:current_user).and_return(user)

      get :index, :format => :html
      expect(response).to be_success
    end
  end

  describe "POST #mute" do
    it "LOGGED IN responds with success and mutes the idea" do
      user = create(:admin_user)
      allow(controller).to receive_message_chain(:current_user).and_return(user)
      idea = create(:idea)
      post :mute, :id => idea.to_param, :format => :html

      expect(response).to be_redirect # as it's created the thing
      assert idea.reload.muted?
    end
  end

  describe "POST #publish" do
    it "LOGGED IN responds with success and publishes the idea" do
      user = create(:admin_user)
      allow(controller).to receive_message_chain(:current_user).and_return(user)
      idea = create(:idea)
      post :publish, :id => idea.to_param, :format => :html

      expect(response).to be_redirect # as it's created the thing
      expect(ZenodoWorker.jobs.size).to eq(1)
      assert idea.reload.published?
    end
  end

  describe "POST #reject" do
    it "LOGGED IN responds with success and removes the idea" do
      user = create(:admin_user)
      allow(controller).to receive_message_chain(:current_user).and_return(user)
      idea = create(:idea)
      post :reject, :id => idea.to_param, :format => :html

      expect(response).to be_redirect # as it's created the thing
      assert idea.reload.rejected?
    end
  end
end
