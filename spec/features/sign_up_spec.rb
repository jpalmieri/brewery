require 'rails_helper'

feature "User signs up", :type => :feature do

  before do
    visit root_path
    within ".user-info" do
      click_link "Sign Up"
    end
    expect(current_path).to eq new_user_registration_path
  end

  scenario "successfully" do
    fill_in "Name", with: "Joe Palmieri"
    fill_in "Email", with: "joe@example.com"
    fill_in "Password", with: "password"
    fill_in "Password confirmation", with: "password"
    click_button "Sign up"

    expect(current_path).to eq recipes_path
    expect(page).to have_content("You have signed up successfully.")
    expect(page).to have_css(".user-info", text: "Log out")
  end

  scenario "unsuccessfully, email already taken" do
    user = create(:user)

    fill_in "Name", with: user.name
    fill_in "Email", with: user.email
    fill_in "Password", with: "password"
    fill_in "Password confirmation", with: "password"
    click_button "Sign up"

    expect(page).to have_content("Email has already been taken")
    expect(page).to have_css("h2", text: "Sign up")
  end
end