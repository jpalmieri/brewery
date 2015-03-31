require 'rails_helper'

feature "User deletes recipe", js: true, :type => :feature do

  before do
    @user1 = create(:user)
    @user2 = create(:user)
    sign_in(@user1)
    @recipe1 = create(:recipe, user: @user1, name: 'Leprechaun Ale', summary: 'A tricky green brew')
    @recipe2 = create(:recipe, user: @user2, name: 'Holland Hefeweizen', summary: 'A wheaty brew with Oranje zest')
  end
  
  scenario "successfully" do
    visit recipe_path @recipe1
    click_link "Delete"

    expect(Recipe.count).to eq(1)
    expect(current_path).to eq(recipes_path)
    expect page.to have_content "Recipe deleted."
  end

  scenario "unsuccessfully, user doesn't own recipe" do 
    visit recipe_path @recipe2

    expect(page).to_not have_content "Delete"
  end

end
