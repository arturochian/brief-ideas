require 'rails_helper'

describe 'ideas/new.html.erb' do
  context 'logged in' do
    it "WITHOUT reference should render properly" do
      user = create(:user)
      allow(view).to receive(:current_user).and_return(user)
      idea = Idea.new
      assign(:idea, idea)

      render :template => "ideas/new.html.erb"

      expect(rendered).to have_content user.name
      expect(rendered).to have_selector('div.form-group', :count => 3)
      expect(rendered).to have_selector('div.references', :count => 0)
    end
  end
end
