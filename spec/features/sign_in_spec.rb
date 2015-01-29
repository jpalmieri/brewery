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
      user = authenticated_user

      visit new_user_session_path

      5.times do
        fill_in "Email", with: user.email
        fill_in "Password", with: "incorrect-password"
        click_button "Log in"
      end

      expect(page).to have_content("Your account is locked.")
    end
  end
end