require 'rails_helper'

feature 'User see recipes at home page' do
  scenario 'with one recipe favorited' do
    recipe = setup_data
    recipe.update(favorite: true)
    visit root_path

    expect(page).to have_css('img[src*="star.png"]')
    expect(page).to have_css('img[alt*="Receita favorita"]')
  end

  scenario 'without a favorited recipe' do
    setup_data
    visit root_path

    expect(page).not_to have_css('img[src*="star.png"]')
    expect(page).not_to have_css('img[alt*="Receita favorita"]')
  end
end

feature 'User favorite recipes' do
  scenario 'successfully' do
    recipe = setup_data
    visit root_path
    click_on recipe.title
    click_on 'Adicionar como receita favorita'
    
    expect(page).to have_css('img[src*="star.png"]')
    expect(page).to have_css('img[alt*="Receita favorita"]')
    expect(page).not_to have_link('Adicionar como receita favorita')
    expect(page).to have_link('Remover das receitas favoritas')
  end

  scenario 'only if the recipe belongs to the user' do
    setup_data
    visit root_path
    click_on Recipe.first.title

    expect(page).not_to have_link('Adicionar como receita favorita')
  end
end

feature 'User unfavorite recipes' do
  scenario 'successfully' do
    recipe = setup_data
    recipe.update(favorite: true)
    visit root_path
    click_on recipe.title
    click_on 'Remover das receitas favorita'

    expect(page).not_to have_css('img[src*="star.png"]')
    expect(page).not_to have_css('img[alt*="Receita favorita"]')
    expect(page).to have_link('Adicionar como receita favorita')
    expect(page).not_to have_link('Remover das receitas favoritas')
  end

  scenario 'only if the recipe belongs to the user' do
    setup_data
    visit root_path
    another_recipe = Recipe.first
    another_recipe.update(favorite: true)
    click_on another_recipe.title

    expect(page).not_to have_link('Remover das receitas favoritas')
  end
end

def setup_data
  user = User.create!(email: 'sanji@cookbook.com', password: 'shonenjump1997')
  another_user = User.create!(email: 'toriko@cookbook.com', password: 'shonenjump2008')
  recipe_type = RecipeType.create(name: 'Sobremesa Hipster')
  cuisine = Cuisine.create(name: 'Internacional')
  login_as(user, scope: :user)
  
  Recipe.create!(title: 'Torta de Abacate', difficulty: 'Médio',
      recipe_type: recipe_type, cuisine: cuisine, cook_time: 120,
      ingredients: 'Abacate, farinha, ovos, decoracoes',
      cook_method: 'Misture tudo, coloque no forno, e apos retirar decore a torta',
      user: another_user, favorite: false)

  Recipe.create!(title: 'Torta de Abacaxi', difficulty: 'Médio',
      recipe_type: recipe_type, cuisine: cuisine, cook_time: 120,
      ingredients: 'Abacaxi, farinha, ovos, decoracoes',
      cook_method: 'Misture tudo, coloque no forno, e apos retirar decore a torta',
      user: user, favorite: false)
end