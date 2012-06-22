require 'spec_helper'

describe "AuthenticationPages" do

  subject { page }

  describe "signin page" do
    before { visit signin_path }

    it { should have_selector('h1', text: 'Sign in') }
    it { should have_title('Sign in') }

    describe "with invalid login information" do
      before { click_button "Sign in" }

      it { should have_title('Sign in') }
      it { should have_error_message('Invalid') }

      describe "after visiting another page" do
        before { click_link "Home" }
        it { should_not have_error_message }
      end
    end

    describe "with valid login information" do
      let(:user) { FactoryGirl.create(:user) }
      before { valid_signin(user) }

      it { should have_title(full_title(user.name)) }

      describe "followed by sign out" do
        before { click_link "Sign out" }
        it { should have_link("Sign in") }
      end
    end
  end
end
