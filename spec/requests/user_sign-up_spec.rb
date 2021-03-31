require 'spec_helper'

describe "User sign up" do

  subject { signup }

  describe "signup", type: :feature do
    before { visit signup_path }

    let(:submit) { "Create User" }

    describe "with invalid information" do
      it "should not sign up the user" do
        expect { click_button submit }.not_to change(User, :count)
      end
    end

    describe "with valid information" do
      before do
        fill_in "Email",        with: "dexter@live.com"
        fill_in "Password",     with: "9TB45TY"
        fill_in "Password confirmation", with: "9TB45TY"
      end

      it "should sign up the user" do
        expect { click_button submit }.to change(User, :count).by(1)
      end
    end
  end
end