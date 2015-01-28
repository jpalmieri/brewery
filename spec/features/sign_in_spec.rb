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
end