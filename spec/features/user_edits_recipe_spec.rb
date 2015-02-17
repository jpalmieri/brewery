require 'rails_helper'

feature "User edits recipe", js: true, :type => :feature do

  before do
    user = create(:user)
    recipe = create(:recipe, user: user)
    sign_in(user)
    visit edit_recipe_path(recipe)
  end

  scenario "successfully" do
    # Only last "Add grain" button should be visible
    expect(page).to have_button("Add grain", count: 1)
    
    expect(page).to have_field("Name", with: "Super dark beer")
    expect(page).to have_field("Style", with: "Black Ale")
    expect(page).to have_field("Batch size", with: "2.5")
    expect(page).to have_field("Enter a yeast name", with: "Windsor")
    expect(page).to have_field("Enter the yeast's average attenuation", with: "75.2")
    expect(page).to have_field("Grain 1 name", with: "2-row")
    expect(page).to have_field("Grain 1 weight", with: "10")
    expect(page).to have_field("Hop 1 name", with: "Cascade")
    expect(page).to have_field("Hop 1 weight", with: "1.5")
    expect(page).to have_field("Summary", with: "A beer to put hair on your chest")
    expect(page).to have_field("Notes", with: "This one will take many manly men to brew. It will also take an exorbant amount of fire and gunpowder. Mash low and slow; get all them sugars out of tha grains.")

    fill_in "Name", with: "Black Stout"
    fill_in "Style", with: "Stout"
    fill_in "Batch size", with: "11.25"
    fill_in "recipe_yeasts_attributes_0_name", with: "Nottingham"
    fill_in "recipe_yeasts_attributes_0_attenuation", with: "78.2"
    fill_in "Grain 1 name", with: "Crystal 40L"
    fill_in "Grain 1 weight", with: "2.25"
    fill_in "Hop 1 name", with: "Fuggle"
    fill_in "Hop 1 weight", with: "2"
    fill_in "Summary", with: "A very dark stout"
    fill_in "Notes", with: "Brew very carefully..."
    
    click_button "Save Recipe"

    expect(Recipe.count).to eq(1)
    expect(current_path).to eq recipe_path(Recipe.first)
    expect(page).to have_content("Black Stout")
    expect(page).to have_content("Nottingham")
    expect(page).to have_content("78.2 %")
    expect(page).to have_content("2-row")
    expect(page).to have_content("10")
    expect(page).to have_content("Crystal 40L")
    expect(page).to have_content("2.25")
    expect(page).to have_content("Cascade")
    expect(page).to have_content("1.5")
    expect(page).to have_content("A very dark stout")
    expect(page).to have_content("Brew very carefully...")
    expect(page).to have_content("1.055")
    expect(page).to have_content("Recipe updated.")
    expect(page).to have_content("11.25 gal.")
  end

  scenario "unsuccessfully, without required fields" do
    # Only last "Add grain" button should be visible
    expect(page).to have_button("Add grain", count: 1)

    fill_in "Name", with: ""
    fill_in "Batch size", with: ""
    fill_in "Grain 1 name", with: ""
    fill_in "Grain 1 weight", with: ""
    fill_in "Hop 1 name", with: ""
    fill_in "Hop 1 weight", with: ""
    fill_in "Grain 2 name", with: ""
    fill_in "Grain 2 weight", with: ""
    fill_in "Hop 2 name", with: ""
    fill_in "Hop 2 weight", with: ""
    fill_in "Grain 3 name", with: ""
    fill_in "Grain 3 weight", with: ""


    click_button "Save Recipe"

    expect(current_path).to eq recipe_path(Recipe.first)
    expect(page).to have_content("There was an error saving your recipe")
    expect(page).to have_content("Name can't be blank")
    expect(page).to have_content("must include name and weight of at least one grain")
    expect(page).to have_content("must include name and weight of at least one hop")
    expect(page).to have_content("Batch size is not a number")
  end

  scenario "unsuccessfully, user doesn't own recipe" do
    other_user = create(:user)
    other_recipe = create(:recipe, user: other_user)
    visit edit_recipe_path(other_recipe)

    expect(current_path).to eq root_path
    expect(page).to have_content("You are not authorized to edit this recipe.")
  end
end
