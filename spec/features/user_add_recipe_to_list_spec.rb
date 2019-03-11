require 'rails_helper'

feature 'User adds Recipe to List' do
  scenario 'successfully' do
    setup_data

    visit root_path
    click_on 'Pão de Queijo de Beterraba'
    select 'Receitas da Renata', from: 'Lista'
    click_on 'Adicionar'

    visit root_path
    click_on 'Peixinho da Horta'
    select 'Receitas da Renata', from: 'Lista'
    click_on 'Adicionar'

    visit root_path
    click_on 'Minhas Listas'
    click_on 'Receitas da Renata'
    
    expect(page).to have_link('Pão de Queijo de Beterraba')
    expect(page).to have_link('Peixinho da Horta')
    expect(page).to have_css('h2', text: 'Total de Receitas da Lista: 2')
  end

  def setup_data
    luis = User.create!(email: 'luis@cookbook.com', password: 't3stp4ssw0rd')
    renata = User.create!(email: 'renata@cookbook.com', password: 't4stp3ssw0rd')
    
    entrada = RecipeType.create(name: 'Entrada')
    prato_principal = RecipeType.create(name: 'Prato Principal')

    cuisine_br = Cuisine.create(name: 'Brasileira')
    cuisine_pt = Cuisine.create(name: 'Portuguesa')

    Recipe.create!(title: 'Pão de Queijo de Beterraba', difficulty: 'Médio',
        recipe_type: entrada, cuisine: cuisine_br, cook_time: 40,
        ingredients: '1 batata média cozida, 1 beterraba cozida, 1/2 xícara de polvilho azedo, 2 colheres de sopa de azeite, 1 olher de chá de sal, 1/2 colher de levedo de cerveja (opcional)',
        cook_method: 'Amasse a batata e a beterraba ainda quentes até quase virar um purê. Em seguida adicione o azeite, levedo de cerveja, sal e misture bem. Adicione o polvilho azedo e o doce...',
        user: renata)
    Recipe.create!(title: 'Peixinho da Horta', difficulty: 'Fácil',
        recipe_type: prato_principal, cuisine: cuisine_pt, cook_time: 30,
        ingredients: 'Folhas de Stachys Bizantina, 1/4 de xícara de farinha de trigo, 1/4 de xícara de fubá...',
        cook_method: 'Lave bem as folhas do peixinho da horta e seque-as muito bem com um pano de prato limpo ou papel toalha...',
        user: renata)
    
    List.create!(name: 'Receitas da Renata', user: luis)
    login_as(luis, scope: :user)
  end
end