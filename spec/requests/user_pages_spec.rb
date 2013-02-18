require 'spec_helper'

describe "User Pages" do
  subject { page }
  
  describe "profile page" do
    let(:user) { FactoryGirl.create(:user) }
    before { visit user_path(user) }
    
    it { should have_selector('h1', text: user.name) }
    it { should have_selector('title', text: user.name) }
  end
  
  describe "signup page" do
    before { visit signup_path }
    
    it { should have_selector('h1', text: 'Sign Up') }
    it { should have_selector('title', text: full_title('Sign Up')) }
  end
  
  describe "signup process" do
    before { visit signup_path }
    
    let(:submit) { "Create my account" }
    
    describe "with invalid information" do
      it "should not create a user" do
        expect { click_button submit }.not_to change(User, :count)
      end
      
      describe "should have 3 errors: invalid email, too short password, passwd != passwd confirm" do
        #before do end block cannot be inside ' it .. ' statement. Get err msg.
        before do
          fill_in "Name",     with: "abcd efgh"
          fill_in "Email",    with: "ae@invalidemail"
          fill_in "Password", with: "foo"
          fill_in "Confirmation", with: "foobaz"
          click_button submit
        end
        
        it { should have_content("Password doesn't match confirmation") }
        it { should have_content("Password is too short (minimum is 6 characters)") }
        it { should have_content("Email is invalid") }
        
      end
      
      describe "after submission" do
        before { click_button submit }
        
        it { should have_selector('title', text: 'Sign Up') }
        it { should have_content('error') }
      end
      
    end
    
    describe "with valid information" do
      before do
        fill_in "Name",         with: "Example User"
        fill_in "Email",        with: "user@example.com"
        fill_in "Password",     with: "foobar"
        fill_in "Confirmation", with: "foobar"
      end
      
      it "should create a user" do
        expect { click_button submit }.to change(User, :count).by(1)
      end
      
      describe "after saving the user " do
        before { click_button submit }
        let(:user) { User.find_by_email('user@example.com') }
        
        it { should have_selector('title', text: user.name) }
        it { should have_selector('div.alert.alert-success', text: 'Welcome') } ## text: 'string' is a match, not a precise comparison.
      end
      
      
      
    end
  end
  
end
