require 'rails_helper'

describe Hop do
  
  before do
    @hop = create(:hop)
  end

  context "associations" do
    it { expect(@hop).to belong_to(:recipe) }
  end

end