require 'rails_helper'

describe 'ideas/show.html.erb' do
  context 'NOT logged in' do
    it "should render properly" do
      allow(view).to receive(:current_user).and_return(nil)
      idea = create(:idea, :tags => ['Funky'])
      assign(:idea, idea)

      render :template => "ideas/show.html.erb"

      expect(rendered).to have_content 'Sign in with ORCID'
      expect(rendered).to have_content idea.title
      expect(rendered).to have_content idea.user.nice_name
      expect(rendered).to have_content 'Funky'
      expect(rendered).to have_content idea.created_at.strftime("%e %b, %Y")
    end
  end

  context 'logged in as author' do
    it "should render properly" do
      user = create(:user)
      allow(view).to receive(:current_user).and_return(user)
      idea = create(:idea, :tags => ['jelly'], :user => user)
      assign(:idea, idea)

      render :template => "ideas/show.html.erb"

      expect(rendered).to have_content user.nice_name
      expect(rendered).to have_content idea.title
      expect(rendered).to have_content idea.user.nice_name
      expect(rendered).to have_content idea.created_at.strftime("%e %b, %Y")
      expect(rendered).to have_content 'pending acceptance'
    end
  end

  context 'logged in as author' do
    it "should render properly for rejected idea" do
      user = create(:user)
      allow(view).to receive(:current_user).and_return(user)
      idea = create(:rejected_idea, :tags => ['jelly'], :user => user)
      assign(:idea, idea)

      render :template => "ideas/show.html.erb"

      expect(rendered).to have_content user.nice_name
      expect(rendered).to have_content idea.title
      expect(rendered).to have_content idea.user.nice_name
      expect(rendered).to have_content idea.created_at.strftime("%e %b, %Y")
      expect(rendered).to have_content 'not accepted'
    end
  end
end
