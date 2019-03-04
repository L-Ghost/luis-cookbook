require 'rails_helper'

feature 'User view its recipes' do
  scenario 'through root, but needs to be authenticated' do
    visit root_path

    expect(page).not_to have_link('Minhas Receitas')
  end

  scenario 'but needs to be authenticated' do
    visit my_recipes_path

    expect(current_path).to eq(new_user_session_path)
  end

  scenario 'successfully' do
    setup_data
    visit root_path
    click_on 'Minhas Receitas'
    
    expect(current_path).to eq(my_recipes_path)
    expect(page).to have_css('h1', text: 'Minhas Receitas')
    expect(page).to have_link('Torta de Morango')
    expect(page).to have_link('Torta de Limão')
    expect(page).not_to have_link('Torta de Abacate')
    expect(page).to have_css('h2', 'Total de Receitas cadastradas: 2')
  end
  
  # informacao inicial necessaria para o teste
  def setup_data
    user = User.create!(email: 'toriko@cookbook.com', password: 'shonenjump2008')
    another_user = User.create!(email: 'sanji@cookbook.com', password: 'shonenjump1997')
    recipe_type = RecipeType.create(name: 'Sobremesa')
    another_recipe_type = RecipeType.create(name: 'Sobremesa Hipster')
    cuisine = Cuisine.create(name: 'Internacional')
    Recipe.create(title: 'Torta de Morango', difficulty: 'Médio',
        recipe_type: recipe_type, cuisine: cuisine, cook_time: 120,
        ingredients: 'Morango, farinha, ovos',
        cook_method: 'Misture tudo e coloque no forno',
        user: user)
    Recipe.create(title: 'Torta de Limão', difficulty: 'Médio',
        recipe_type: recipe_type, cuisine: cuisine, cook_time: 120,
        ingredients: 'Limão, farinha, ovos',
        cook_method: 'Misture tudo e coloque no forno',
        user: user)
    Recipe.create(title: 'Torta de Abacate', difficulty: 'Médio',
        recipe_type: another_recipe_type, cuisine: cuisine, cook_time: 120,
        ingredients: 'Abacate, farinha, ovos, decoracoes',
        cook_method: 'Misture tudo, coloque no forno, e apos retirar decore a torta',
        user: user)
    login_as(user, scope: :user)
  end
end