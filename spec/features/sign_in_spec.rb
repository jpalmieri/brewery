require 'rails_helper'

describe "Sign in flow" do

  describe "successful" do
    it "redirects to the recipe index" do
      user = create(:user)
      sign_in(user)

      expect(current_path).to eq root_path
      expect(page).to_not have_css(".user-info", text: "Sign In")
      expect(page).to have_css(".user-info", text: user.email)
    end
  end
end