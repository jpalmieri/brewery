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
  end

end