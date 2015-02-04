require 'rails_helper'

describe Recipe do
  
  before do
    @recipe = create(:recipe)
  end

  context "associations" do
    it { expect(@recipe).to belong_to(:user) }
  end

  context "validations" do
    it { expect(@recipe).to validate_presence_of(:name) }
    it { expect(@recipe).to validate_presence_of(:user_id) }
    it { expect(@recipe).to validate_presence_of(:grains).with_message(/must include name and weight of at least one grain/) }
    it { expect(@recipe).to validate_presence_of(:hops).with_message(/must include name and weight of at least one hop/) }
    it { expect(@recipe.total_grain_weight).to_not be_nil }
    it { expect(@recipe.batch_size).to_not be_nil }
  end

  context "#original_gravity" do

    it "should calculate the original gravity" do
      recipe = Recipe.new()
      allow(recipe).to receive(:total_grain_weight) {9.5}
      expect((recipe.original_gravity).round(3)).to eq(1.053)
    end
  end

end