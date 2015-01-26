require 'rails_helper'

feature "User creates recipes", :type => :feature do

  before do
    user = create(:user)
    sign_in(user)
  end
  
  scenario "successfully" do
    visit new_recipe_path
    fill_in "Name", with: "Black Stout"
    fill_in "Style", with: "Stout"
    fill_in "Yeast", with: "Nottingham"
    fill_in "Grain 1 name", with: "2-row"
    fill_in "Grain 1 weight", with: "10"
    fill_in "Grain 2 name", with: "Crystal 40L"
    fill_in "Grain 2 weight", with: "2.25" 
    fill_in "Summary", with: "A very dark stout"
    fill_in "Notes", with: "Brew very carefully..."

    click_button "Save Recipe"

    expect(current_path).to eq recipe_path(id: Recipe.first)
    expect(page).to have_content("Black Stout")
    expect(page).to have_content("Nottingham")
    expect(page).to have_content("2-row")
    expect(page).to have_content("10")
    expect(page).to have_content("Crystal 40L")
    expect(page).to have_content("2.25")
    expect(page).to have_content("A very dark stout")
    expect(page).to have_content("Black Stout")
    expect(page).to have_content("Brew very carefully...")
    expect(page).to have_content("Recipe saved.")
  end

  scenario "unsuccessfully" do 
    visit new_recipe_path
    fill_in "Yeast", with: "Nottingham"

    click_button "Save Recipe"

    expect(current_path).to eq new_recipe_path
    expect(page).to have_content("Name can't be blank")
    expect(page).to have_content("Must include at least one grain")
  end

end
