require 'rails_helper'

feature "Anonymous user" do

  feature "clicks 'New Recipe'" do
    scenario "is redirected to sign in page" do
      visit root_path
      click_link "New Recipe"

      expect(current_path).to eq new_user_session_path
      expect(page).to have_content("You need to sign in or sign up before continuing.")
    end
  end

  feature "views saved recipe" do
    scenario "successfully" do
      recipe = create(:recipe)
      visit recipe_path(Recipe.first)
      
      expect(current_path).to eq recipe_path(Recipe.first)
    end
  end
end