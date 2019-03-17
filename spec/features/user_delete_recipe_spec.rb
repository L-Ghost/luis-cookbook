require 'rails_helper'

feature 'User delete recipe' do
  scenario 'successfully' do
    # dados para o teste
    user = create(:user)
    another_user = create(:user)
    
    entrada = create(:recipe_type, name: 'Entrada')
    prato_principal = create(:recipe_type, name: 'Prato Principal')
    cuisine_br = create(:cuisine, name: 'Brasileira')
    cuisine_pt = create(:cuisine, name: 'Portuguesa')

    recipe = create(:recipe, title: 'Pão de Queijo de Beterraba', difficulty: 'Médio',
        recipe_type: entrada, cuisine: cuisine_br, cook_time: 40,
        ingredients: '1 batata média cozida, 1 beterraba cozida, 1/2 xícara de polvilho azedo, 2 colheres de sopa de azeite, 1 olher de chá de sal, 1/2 colher de levedo de cerveja (opcional)',
        cook_method: 'Amasse a batata e a beterraba ainda quentes até quase virar um purê. Em seguida adicione o azeite, levedo de cerveja, sal e misture bem. Adicione o polvilho azedo e o doce...',
        user: user)
    recipe2 = create(:recipe, title: 'Peixinho da Horta', difficulty: 'Fácil',
        recipe_type: prato_principal, cuisine: cuisine_pt, cook_time: 30,
        ingredients: 'Folhas de Stachys Bizantina, 1/4 de xícara de farinha de trigo, 1/4 de xícara de fubá...',
        cook_method: 'Lave bem as folhas do peixinho da horta e seque-as muito bem com um pano de prato limpo ou papel toalha...',
        user: user)
    
    login_as(user, scope: :user)
    visit root_path
    click_on recipe.title
    click_on 'Deletar'

    expect(current_path).to eq(root_path)
    expect(Recipe.count).to eq(1)
    expect(page).not_to have_css('h1', text: 'Pão de Queijo de Beterraba')
    expect(page).to have_css('h1', text: 'Peixinho da Horta')
  end

  scenario 'only if the recipe belongs to the user' do
    # dados para o teste
    user = create(:user)
    another_user = create(:user)
    
    entrada = create(:recipe_type, name: 'Entrada')
    prato_principal = create(:recipe_type, name: 'Prato Principal')
    cuisine_br = create(:cuisine, name: 'Brasileira')
    cuisine_pt = create(:cuisine, name: 'Portuguesa')

    recipe = create(:recipe, title: 'Pão de Queijo de Beterraba', difficulty: 'Médio',
        recipe_type: entrada, cuisine: cuisine_br, cook_time: 40,
        ingredients: '1 batata média cozida, 1 beterraba cozida, 1/2 xícara de polvilho azedo, 2 colheres de sopa de azeite, 1 olher de chá de sal, 1/2 colher de levedo de cerveja (opcional)',
        cook_method: 'Amasse a batata e a beterraba ainda quentes até quase virar um purê. Em seguida adicione o azeite, levedo de cerveja, sal e misture bem. Adicione o polvilho azedo e o doce...',
        user: user)
    another_recipe = create(:recipe, title: 'Peixinho da Horta', difficulty: 'Fácil',
        recipe_type: prato_principal, cuisine: cuisine_pt, cook_time: 30,
        ingredients: 'Folhas de Stachys Bizantina, 1/4 de xícara de farinha de trigo, 1/4 de xícara de fubá...',
        cook_method: 'Lave bem as folhas do peixinho da horta e seque-as muito bem com um pano de prato limpo ou papel toalha...',
        user: another_user)
    
    login_as(user, scope: :user)
    visit root_path
    click_on another_recipe.title

    expect(page).not_to have_link('Deletar')
  end
  
end