require 'rails_helper'

feature "User creates recipe", :type => :feature do

  before do
    user = create(:user)
    sign_in(user)
    visit new_recipe_path
    fill_in "Style", with: "Stout"
    fill_in "Yeast name", with: "Nottingham"
    fill_in "Yeast attenuation", with: "78"
    fill_in "Summary", with: "A very dark stout"
    fill_in "Notes", with: "Brew very carefully..."
  end
  
  scenario "successfully" do
    fill_in "Name", with: "Black Stout"
    fill_in "Grain 1 name", with: "2-row"
    fill_in "Grain 1 weight", with: "10"
    fill_in "Grain 2 name", with: "Crystal 40L"
    fill_in "Grain 2 weight", with: "2.25" 
    fill_in "Hop 1 name", with: "Cascade"
    fill_in "Hop 1 weight", with: "1.5"
    fill_in "Batch size", with: "5.25"

    click_button "Save Recipe"
expect(page).to have_content("Black Stout")
    expect(Recipe.count).to eq(1)
    expect(current_path).to eq recipe_path(Recipe.first)
    expect(page).to have_content("Black Stout")
    expect(page).to have_content("Nottingham")
    expect(page).to have_content("78")
    expect(page).to have_content("2-row")
    expect(page).to have_content("10")
    expect(page).to have_content("Crystal 40L")
    expect(page).to have_content("2.25")
    expect(page).to have_content("Cascade")
    expect(page).to have_content("1.5")
    expect(page).to have_content("A very dark stout")
    expect(page).to have_content("Brew very carefully...")
    expect(page).to have_content("Recipe saved.")
    expect(page).to have_content("5.25 gal.")
  end

  scenario "unsuccessfully, without required fields" do 
    # Batch size has default value in view
    fill_in "Batch size", with: ""
    
    click_button "Save Recipe"

    expect(current_path).to eq recipes_path
    expect(page).to have_content("Name can't be blank")
    expect(page).to have_content("must include name and weight of at least one grain")
    expect(page).to have_content("must include name and weight of at least one hop")
    expect(page).to have_content("Batch size can't be blank")

    # check that field values persist
    expect(page).to have_selector("input[value='Stout']")
    expect(page).to have_selector("input[value='Nottingham']")
    expect(page).to have_selector("input[value='A very dark stout']")
    expect(page).to have_selector("input[value='Brew very carefully...']")

    # check that grain fields show
    expect(page).to have_content("Grain 1 name")
    expect(page).to have_content("Grain 1 weight")
    expect(page).to have_content("Grain 2 name")
    expect(page).to have_content("Grain 2 weight")
    expect(page).to have_content("Grain 3 name")
    expect(page).to have_content("Grain 3 weight")
  end

  scenario "unsuccessfully, without grain and hop weights" do 
    fill_in "Name", with: "Black Stout"
    fill_in "Grain 1 name", with: "2-row"
    fill_in "Hop 1 name", with: "Cascade"
    click_button "Save Recipe"

    expect(current_path).to eq recipes_path
    expect(page).to have_content("Grains weight can't be blank")
    expect(page).to have_selector("input[value='2-row']")
    expect(page).to have_content("Hops weight can't be blank")
    expect(page).to have_selector("input[value='Cascade']")
  end

  scenario "unsuccessfully, without grain and hop names" do 
    fill_in "Name", with: "Black Stout"
    fill_in "Grain 1 weight", with: "10"
    fill_in "Hop 1 weight", with: "1.5"
    click_button "Save Recipe"

    expect(current_path).to eq recipes_path
    expect(page).to have_content("Grains name can't be blank")
    expect(page).to have_selector("input[value='10']")
    expect(page).to have_content("Hops name can't be blank")
    expect(page).to have_selector("input[value='1.5']")
  end

end
