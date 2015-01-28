require 'rails_helper'

describe Grain do
  
  before do
    @grain = create(:grain)
  end

  context "associations" do
    it { expect(@grain).to belong_to(:recipe) }
  end

end