FactoryGirl.define do
  factory :recipe do
    name "Name"
    style "Style"
    batch_size 2.5

    before(:create) do |recipe, yeast|
      # Only allowing one Yeast on form submission for now
      recipe.yeasts_attributes = [attributes_for(:yeast)]
    end

    before(:create) do |recipe, grain|
      grains_attributes = []
      3.times do 
        grains_attributes << attributes_for(:grain)
      end
      recipe.grains_attributes = grains_attributes
    end

    before(:create) do |recipe, hop|
      hops_attributes = []
      2.times do 
        hops_attributes << attributes_for(:hop)
      end
      recipe.hops_attributes = hops_attributes
    end

    summary "Summary"
    notes "Notes notes notes"
    user
  end
end