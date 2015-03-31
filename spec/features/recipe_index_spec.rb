require 'rails_helper'

feature "View all recipes", js: true do

  before do
    user = create(:user)
    sign_in(user)
    @recipe1 = create(:recipe, name: 'Leprechaun Ale', summary: 'A tricky green brew')
    @recipe2 = create(:recipe, name: 'Holland Hefeweizen', summary: 'A wheaty brew with Oranje zest')

    within('.navbar') do
      click_link "All Recipes"
    end
  end

  scenario "successfully" do

    expect(current_path).to eq(recipes_path)

    expect( page ).to have_content(@recipe1.name)
    expect( page ).to have_content(@recipe1.summary)
    expect( page ).to have_css("div.recipe-owner", text: @recipe1.user.name)
    expect( page ).to have_content(@recipe2.name)
    expect( page ).to have_content(@recipe2.summary)
    expect( page ).to have_css("div.recipe-owner", text: @recipe2.user.name)
  end
end