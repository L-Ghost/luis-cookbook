FactoryBot.define do
  factory :recipe_type do
    sequence(:name) {|i| "Recipe Type #{i}"}
  end
end