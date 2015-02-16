require 'factory_girl'
 
FactoryGirl.define do
  factory :hop do
    name "Cascade"
    weight 1.5
    boil_time 60
  end
end