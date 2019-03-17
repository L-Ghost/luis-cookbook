FactoryBot.define do
  factory :cuisine do
    sequence(:name) {|i| "Cuisine #{i}"}
  end
end