require 'rails_helper'

feature "View all recipes", js: true do

  def navigate_to_index
    within('.navbar') do click_link "All Recipes" end
  end

  before do
    visit root_path
    @user = create(:user)
    @recipe1 = create(:recipe, name: 'Leprechaun Ale', summary: 'A tricky green brew')
    @recipe2 = create(:recipe, name: 'Holland Hefeweizen', summary: 'A wheaty brew with Oranje zest')
  end

  scenario "successfully as registered user" do
    sign_in(@user)
    navigate_to_index
  end

  scenario "successfully as unregistered user" do
    navigate_to_index
  end

  after do
    expect(current_path).to eq(recipes_path)
    expect( page ).to have_content(@recipe1.name)
    expect( page ).to have_content(@recipe1.summary)
    expect( page ).to have_css("div.recipe-owner", text: @recipe1.user.name)
    expect( page ).to have_content(@recipe2.name)
    expect( page ).to have_content(@recipe2.summary)
    expect( page ).to have_css("div.recipe-owner", text: @recipe2.user.name)
  end
end
