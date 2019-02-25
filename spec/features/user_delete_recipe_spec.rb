require 'rails_helper'

feature 'User delete recipe' do
  
  scenario 'successfully' do
    # dados de receitas para o teste
    entrada = RecipeType.create(name: 'Entrada')
    prato_principal = RecipeType.create(name: 'Prato Principal')

    cuisine_br = Cuisine.create(name: 'Brasileira')
    cuisine_pt = Cuisine.create(name: 'Portuguesa')

    recipe = Recipe.create(title: 'Pão de Queijo de Beterraba', difficulty: 'Médio',
        recipe_type: entrada, cuisine: cuisine_br, cook_time: 40,
        ingredients: '1 batata média cozida, 1 beterraba cozida, 1/2 xícara de polvilho azedo, 2 colheres de sopa de azeite, 1 olher de chá de sal, 1/2 colher de levedo de cerveja (opcional)',
        cook_method: 'Amasse a batata e a beterraba ainda quentes até quase virar um purê. Em seguida adicione o azeite, levedo de cerveja, sal e misture bem. Adicione o polvilho azedo e o doce...')
    recipe2 = Recipe.create(title: 'Peixinho da Horta', difficulty: 'Fácil',
        recipe_type: prato_principal, cuisine: cuisine_pt, cook_time: 30,
        ingredients: 'Folhas de Stachys Bizantina, 1/4 de xícara de farinha de trigo, 1/4 de xícara de fubá...',
        cook_method: 'Lave bem as folhas do peixinho da horta e seque-as muito bem com um pano de prato limpo ou papel toalha...')
    
    visit root_path
    click_on recipe.title
    click_on 'Deletar'

    expect(current_path).to eq(root_path)
    expect(Recipe.count).to eq(1)
    expect(page).not_to have_css('h1', 'Pão de Queijo de Beterraba')
    expect(page).to have_css('h1', 'Peixinho da Horta')
  end

end