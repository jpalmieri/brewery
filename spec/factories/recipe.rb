FactoryGirl.define do
  factory :recipe do
    name "Name"
    style "Style"
    yeast "Yeast"
    summary "Summary"
    notes "Notes notes notes"
    user
  end
end