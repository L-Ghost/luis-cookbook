require 'rails_helper'

feature 'User edit recipe' do
  
  scenario 'successfully' do
    # dados da receita para o teste
    recipe_type = RecipeType.create(name: 'Entrada')
    cuisine = Cuisine.create(name: 'Brasileira')
    cuisine2 = Cuisine.create(name: 'Mineira')
    recipe = Recipe.create(title: 'Pão de Queijo de Beterraba', difficulty: 'Médio',
        recipe_type: recipe_type, cuisine: cuisine, cook_time: 40,
        ingredients: '1 batata média cozida, 1 beterraba cozida, 1/2 xícara de polvilho azedo, 2 colheres de sopa de azeite, 1 olher de chá de sal, 1/2 colher de levedo de cerveja (opcional)',
        cook_method: 'Amasse a batata e a beterraba ainda quentes até quase virar um purê. Em seguida adicione o azeite, levedo de cerveja, sal e misture bem. Adicione o polvilho azedo e o doce...')
    
    setup_user
    visit root_path
    click_on recipe.title
    click_on 'Editar'

    expect(page).to have_css('h1', text: 'Edição de Receitas')
    
    # dados modificados
    fill_in 'Dificuldade', with: 'Difícil'
    fill_in 'Tempo de Preparo', with: 45
    select 'Mineira', from: 'Cozinha'

    click_on 'Enviar'

    expect(page).to have_css('h1', text: 'Pão de Queijo de Beterraba')
    expect(page).to have_css('h3', text: 'Detalhes')
    expect(page).not_to have_css('p', text: 'Médio')
    expect(page).to have_css('p', text: 'Difícil')
    expect(page).to have_css('p', text: 'Entrada')
    expect(page).not_to have_css('p', text: 'Brasileira')
    expect(page).to have_css('p', text: 'Mineira')
    expect(page).not_to have_css('p', text: '40 minutos')
    expect(page).to have_css('p', text: '45 minutos')

    expect(page).to have_css('h3', text: 'Ingredientes')
    expect(page).to have_css('p', text: '1 batata média cozida, 1 beterraba cozida, 1/2 xícara de polvilho azedo, 2 colheres de sopa de azeite, 1 olher de chá de sal, 1/2 colher de levedo de cerveja (opcional)')
    expect(page).to have_css('h3', text: 'Como Preparar')
    expect(page).to have_css('p', text: 'Amasse a batata e a beterraba ainda quentes até quase virar um purê. Em seguida adicione o azeite, levedo de cerveja, sal e misture bem. Adicione o polvilho azedo e o doce...')
  end
  
  scenario 'and should not leave some fields blank' do
    recipe_type = RecipeType.create(name: 'Prato Principal')
    cuisine = Cuisine.create(name: 'Portuguesa')
    recipe = Recipe.create(title: 'Peixinho da Horta', difficulty: 'Fácil',
        recipe_type: recipe_type, cuisine: cuisine, cook_time: 30,
        ingredients: 'Folhas de Stachys Bizantina, 1/4 de xícara de farinha de trigo, 1/4 de xícara de fubá...',
        cook_method: 'Lave bem as folhas do peixinho da horta e seque-as muito bem com um pano de prato limpo ou papel toalha...')
    
    setup_user
    visit root_path
    click_on recipe.title
    click_on 'Editar'

    # dados modificados
    fill_in 'Nome', with: ''
    fill_in 'Ingredientes', with: ''
    fill_in 'Modo de Preparo', with: ''

    click_on 'Enviar'
    expect(page).to have_content('Não foi possível salvar a Receita')
    expect(page).to have_css('h1', text: 'Edição de Receitas')
  end

  # create data for login
  def setup_user
    user = User.create!(email: 'emailtest@cookbook.com', password: 't3stp4ssw0rd')
    login_as(user, scope: :user)
  end
  
end