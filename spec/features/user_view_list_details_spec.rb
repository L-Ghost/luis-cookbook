require 'rails_helper'

feature 'User view list details' do
  scenario 'successfully' do
    setup_data
    visit root_path
    click_on 'Minhas Listas'
    click_on 'Tortas'

    expect(page).to have_css('h1', text: 'Tortas')
    expect(page).to have_link('Torta de Abacate')
    expect(page).to have_link('Torta de Abacaxi')
    expect(page).to have_css('h2', text: 'Total de Receitas da Lista: 2')
  end

  def setup_data
    user = create(:user)
    recipe_type = create(:recipe_type, name: 'Sobremesa')
    cuisine = create(:cuisine, name: 'Internacional')

    torta_abacate = create(:recipe, title: 'Torta de Abacate', difficulty: 'Médio',
      recipe_type: recipe_type, cuisine: cuisine, cook_time: 120,
      ingredients: 'Abacate, farinha, ovos, decoracoes',
      cook_method: 'Misture tudo, coloque no forno, e apos retirar decore a torta',
      user: user)
    torta_abacaxi = create(:recipe, title: 'Torta de Abacaxi', difficulty: 'Médio',
      recipe_type: recipe_type, cuisine: cuisine, cook_time: 120,
      ingredients: 'Abacaxi, farinha, ovos, decoracoes',
      cook_method: 'Misture tudo, coloque no forno, e apos retirar decore a torta',
      user: user)
    
    list = create(:list, name: 'Tortas', user: user)
    create(:list_recipe, list: list, recipe: torta_abacate)
    create(:list_recipe, list: list, recipe: torta_abacaxi)
    
    login_as(user, scope: :user)
  end
end