require 'rails_helper'

describe Yeast do
  
  before do
    @yeast = Yeast.new#create(:yeast)
  end

  context "associations" do
    it { expect(@yeast).to belong_to(:recipe) }
  end

  context "validations" do
    it { expect(@yeast).to validate_presence_of(:name) }
    it { expect(@yeast).to validate_numericality_of(:attenuation) }
  end

end
