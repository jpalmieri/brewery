require 'rails_helper'

feature "User signs in" do

  before do
    @user = create(:user)
  end

  feature "successfully" do
    scenario "and is redirected to the recipe index" do
      sign_in(@user)

      expect(current_path).to eq recipes_path
      expect(page).to_not have_css(".user-info", text: "Sign In")
      expect(page).to have_css(".user-info", text: @user.name)
    end

    scenario "and is redirected to recipes_path when visiting root_path" do
      sign_in(@user)
      visit root_path
      expect(current_path).to eq recipes_path
    end
  end

  feature "unsuccessfully" do
    scenario "locked out after 5 attempts" do
      visit new_user_session_path

      4.times do
        fill_in "Email", with: @user.email
        fill_in "Password", with: "incorrect-password"
        click_button "Sign in"
      end

      expect(page).to have_content("You have one more attempt before your account is locked.")

      fill_in "Email", with: @user.email
      fill_in "Password", with: "incorrect-password"
      click_button "Sign in"

      expect(page).to have_content("Your account is locked due to 5 failed attempts.")
      expect(page).to have_content("Please allow 15 minutes before attempting to log in again.")
    end
  end
end