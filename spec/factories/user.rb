FactoryGirl.define do
  factory :user do
    transient do
      skip_confirmation true
    end

    name "Eliot Sykes"
    sequence(:email, 100) { |n| "person#{n}@example.com" }
    password "password"
    
    before(:create) do |user, evaluator|
      user.skip_confirmation! if evaluator.skip_confirmation
    end
  end
end
