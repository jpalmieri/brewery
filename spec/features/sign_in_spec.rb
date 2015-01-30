require 'rails_helper'

feature "Sign in flow" do

  feature "successful" do
    scenario "redirects to the recipe index" do
      user = create(:user)
      sign_in(user)

      expect(current_path).to eq root_path
      expect(page).to_not have_css(".user-info", text: "Sign In")
      expect(page).to have_css(".user-info", text: user.email)
    end
  end

  feature "unsuccessfully" do
    scenario "locked out after 5 attempts" do
      user = create(:user)

      visit new_user_session_path

      4.times do
        fill_in "Email", with: user.email
        fill_in "Password", with: "incorrect-password"
        click_button "Log in"
      end

      expect(page).to have_content("You have one more attempt before your account is locked.")

      fill_in "Email", with: user.email
      fill_in "Password", with: "incorrect-password"
      click_button "Log in"

      expect(page).to have_content("Your account is locked due to 5 failed attempts.")
      expect(page).to have_content("Please allow 15 minutes before attempting to log in again.")
    end
  end
end