require 'rails_helper'

feature 'User search Recipe' do
  before(:all) do
    recipe_type = RecipeType.create(name: 'Sobremesa')
    cuisine = Cuisine.create(name: 'Internacional')
    Recipe.create(title: 'Torta de Morango', difficulty: 'Médio',
        recipe_type: recipe_type, cuisine: cuisine, cook_time: 120,
        ingredients: 'Morango, farinha, ovos',
        cook_method: 'Misture tudo e coloque no forno')
    Recipe.create(title: 'Torta de Limão', difficulty: 'Médio',
        recipe_type: recipe_type, cuisine: cuisine, cook_time: 120,
        ingredients: 'Limão, farinha, ovos',
        cook_method: 'Misture tudo e coloque no forno')
  end

  after(:all) do
    Recipe.delete_all
    RecipeType.delete_all
    Cuisine.delete_all
  end

  scenario 'and finds a recipe' do
    visit root_path
    click_on 'Buscar uma Receita'
    expect(page).to have_css('h1', text: 'Busca de Receitas')
    
    fill_in 'Procurar por', with: 'Morango'
    click_on 'Buscar'
    
    expect(page).to have_css('h2', text: 'Total de Receitas encontradas: 1')
    expect(page).to have_content('Torta de Morango')
    expect(page).not_to have_content('Torta de Limão')
  end

  scenario 'and finds no recipe' do
    visit root_path
    click_on 'Buscar uma Receita'

    fill_in 'Procurar por', with: 'Bolo'
    click_on 'Buscar'

    expect(page).to have_css('h2', text: 'Total de Receitas encontradas: 0')
    expect(page).not_to have_content('Torta de Morango')
    expect(page).not_to have_content('Torta de Limão')
  end

  scenario 'and finds more than one recipe' do
    visit root_path
    click_on 'Buscar uma Receita'

    fill_in 'Procurar por', with: 'Torta'
    click_on 'Buscar'

    expect(page).to have_css('h2', text: 'Total de Receitas encontradas: 2')
    expect(page).to have_content('Torta de Morango')
    expect(page).to have_content('Torta de Limão')
  end

end