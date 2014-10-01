require 'spec_helper'

describe "Static pages" do
  
  subject { page }
  
  describe "Home page" do
    before { visit root_path }

    it { should have_content('Sample App') }
    it { should have_selector('title', text: full_title('')) }
    it { should_not have_selector 'title', text: '| Home' }

    describe "for signed-in users" do
      let(:user) { FactoryGirl.create(:user) }
      #after { user.delete }
      before do
        FactoryGirl.create(:micropost, user: user, content: "Lorem ipsum")
        FactoryGirl.create(:micropost, user: user, content: "Dolor sit amet")
        sign_in user
        visit root_path
      end

      it "should render the user's feed" do
        user.feed.each do |item|
          page.should have_selector("li##{item.id}", text: item.content)
        end
      end

      describe "follower/following counts" do
        let(:other_user) { FactoryGirl.create(:user) }
        before do
          other_user.follow!(user)
          visit root_path
        end

        it { should have_link("0 following", href: following_user_path(user)) }
        it { should have_link("1 follower", href: followers_user_path(user)) }
      end

      it "should have the right microposts counts in the sidebar" do
        page.should have_selector('span', text: "#{user.microposts.count} microposts")
      end

=begin
      describe "pagination" do
        before(:all) { 30.times { FactoryGirl.create(:micropost, user: user) } }
        after(:all)  { user.microposts.delete_all }

        it { should have_selector('div', class: 'pagination') }

        it "should list each micropost" do
          user.feed.paginate(page: 1).each do |micropost|
            page.should have_selector('span', class:'content', text: micropost.content)
          end
        end
      end #pagination end
=end
    end #signed_in users end

  end

  describe "Help page" do
    before { visit help_path }

    it { should have_content('Help') }
    it { should have_selector('h1', text: 'Help') }
  end

  describe "About page" do
    before { visit about_path }

    it { should have_content('About') }
    it { should have_selector('title', text: full_title('About Us')) }
  end

  describe "Contact page" do
    before { visit contact_path }

    it { should have_content('Contact') }
    it { should have_selector('title', text: full_title('Contact')) }
  end
end
