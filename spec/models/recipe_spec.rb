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
    it { expect(@recipe).to validate_presence_of(:hops).with_message(/must fill out all hop fields/) }
    it { expect(@recipe.total_grain_weight).to_not be_nil }
    it { expect(@recipe.batch_size).to_not be_nil }
    it { expect(@recipe).to validate_numericality_of(:batch_size) }
  end

  context "#original_gravity" do

    it "should calculate the original gravity" do
      recipe = Recipe.new()
      allow(recipe).to receive(:batch_size) {5}
      allow(recipe).to receive(:total_grain_weight) {9.5}
      expect((recipe.original_gravity).round(3)).to eq(1.053)
    end
  end

  context "#final_gravity" do

    it "should calculate the final gravity" do
      recipe = Recipe.new()
      allow(recipe).to receive(:original_gravity) {1.069}
      allow(recipe).to receive(:avg_attenuation) {0.755}
      expect((recipe.final_gravity).round(3)).to eq(1.017)
    end
  end

  context "#total_grain_weight" do
    it "should calculate the total grain weight" do
      recipe = create(:recipe)
      recipe.grains.destroy_all
      recipe.grains.build(name: "2-row", weight: 10)
      recipe.grains.build(name: "Black Patent", weight: 2.5)
      recipe.save

      expect(recipe.total_grain_weight).to eq(12.5)
    end
  end

  context "#avg_attenuation" do
    it "should calculate average attenuation of yeasts" do
      recipe = create(:recipe)
      recipe.yeasts.destroy_all
      recipe.yeasts.build(name: "Windsor", attenuation: 75.5)
      recipe.yeasts.build(name: "Nottingham", attenuation: 68)
      recipe.save

      expect(recipe.avg_attenuation * 100).to eq(71.75)
    end
  end

end
