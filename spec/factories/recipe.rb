FactoryGirl.define do
  factory :recipe do
    name "Super dark beer"
    style "Black Ale"
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

    summary "A beer to put hair on your chest"
    notes "This one will take many manly men to brew. It will also take an exorbant amount of fire and gunpowder. Mash low and slow; get all them sugars out of tha grains."
    user
  end
end