FactoryGirl.define do
  factory :recipe do
    name "Name"
    style "Style"

    before(:create) do |recipe, grain|
      grains_attributes = []
      3.times do 
        grains_attributes << attributes_for(:grain)
      end
      recipe.grains_attributes = grains_attributes
    end

    yeast "Yeast"
    summary "Summary"
    notes "Notes notes notes"
    user
  end
end