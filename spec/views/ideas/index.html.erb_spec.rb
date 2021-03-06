require 'rails_helper'

describe 'ideas/index.html.erb' do
  context 'NOT logged in' do
    it "should render properly with some papers" do
      allow(view).to receive(:current_user).and_return(nil)
      ideas = []
      3.times do
        create(:idea)
      end

      assign(:ideas, Idea.all.paginate(:page => 1, :per_page => 10))

      render :template => "ideas/index.html.erb"

      expect(rendered).to have_content 'Ideas from the last week'
      expect(rendered).to have_selector('div.idea', :count => 3)
      expect(rendered).to have_content 'Sign in with ORCID'
    end
  end

  context 'logged in' do
    it "should render properly without papers" do
      user = create(:user)
      allow(view).to receive(:current_user).and_return(user)
      ideas = []

      assign(:ideas, Idea.all.paginate(:page => 1, :per_page => 10))

      render :template => "ideas/index.html.erb"

      expect(rendered).to have_selector('div.idea', :count => 0)
      expect(rendered).to have_content 'There are no ideas currently'
      expect(rendered).to have_content user.nice_name
    end
  end
end
