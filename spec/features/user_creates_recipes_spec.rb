require 'rails_helper'

feature "User creates recipes", :type => :feature do
  
  scenario "successfully" do
    visit new_recipe_path
    fill_in "Name", with: "Black Stout"
    fill_in "Style", with: "Stout"
    fill_in "Yeast", with: "Nottingham"
    fill_in "Summary", with: "A very dark stout"
    fill_in "Notes", with: "Brew very carefully..."

    click_button "Save Recipe"

    expect(current_path).to eq recipe_path(id: Recipe.first)
    expect(page).to have_content("Black Stout")
    expect(page).to have_content("Nottingham")
    expect(page).to have_content("A very dark stout")
    expect(page).to have_content("Black Stout")
    expect(page).to have_content("Brew very carefully...")
    expect(page).to have_content("Recipe saved.")
  end

end
