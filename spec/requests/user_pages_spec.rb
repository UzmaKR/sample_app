require 'spec_helper'

describe "User Pages" do
  subject { page }
  
  shared_examples_for "all User pages" do
    it { should have_selector('h1', text: 'Sign Up') }
    it { should have_selector('title', text: full_title('Sign Up')) }
  end
  
  describe "signup page" do
    before { visit signup_path }
    it_should_behave_like "all User pages"
  end
  
end
