FactoryBot.define do
  factory :recipe do
    { title: 'Recipe' }
    { difficulty: 'Médio' }
    { cook_time: Random.rand(101) + 20 }
    { ingredients: 'Sal e Açúcar' }
    { cook_method: 'Atenção' }
    recipe_type
    cuisine
    user
  end
end