require 'rails_helper'

describe Yeast do
  
  before do
    @yeasr = create(:yeast)
  end

  context "associations" do
    it { expect(@yeast).to belong_to(:recipe) }
  end

end
