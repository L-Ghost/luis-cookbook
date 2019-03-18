require 'rails_helper'

feature 'User navigate through cookbook' do
  scenario 'going to recipe details and back' do
    setup_data

    visit root_path
    click_on 'Receita de Farinha'
    click_on 'Voltar'

    expect(current_path).to eq(root_path)
  end

  scenario 'going to recipe from its lists and back' do
    setup_data

    visit root_path
    click_on 'Minhas Receitas'
    click_on 'Receita de Farinha'
    click_on 'Voltar'
    click_on 'Voltar'

    expect(current_path).to eq(root_path)
  end

  scenario 'going to list and back' do
    user = setup_data
    create(:list, name: 'Lista X', user: user)

    visit root_path
    click_on 'Minhas Listas'
    click_on 'Lista X'
    click_on 'Voltar'
    click_on 'Voltar'

    expect(current_path).to eq(root_path)
  end

  scenario 'going to lists and back' do
    setup_data
    create(:list, name: 'Lista X')

    visit root_path
    click_on 'Minhas Listas'
    click_on 'Voltar'

    expect(current_path).to eq(root_path)
  end

  scenario 'going to search and back' do
    setup_data

    visit root_path
    click_on 'Buscar uma Receita'
    click_on 'Voltar'

    expect(current_path).to eq(root_path)
  end

  scenario 'going to recipe registering and back' do
    setup_data

    visit root_path
    click_on 'Cadastrar nova Receita'
    click_on 'Voltar'

    expect(current_path).to eq(root_path)
  end

  scenario 'going to recipe editing and back' do
    setup_data
    recipe = Recipe.first

    visit root_path
    click_on recipe.title
    click_on 'Editar'
    click_on 'Voltar'

    expect(current_path).to eq(recipe_path(recipe))
  end

  scenario 'going to recipe type registering and back' do
    setup_data

    visit root_path
    click_on 'Cadastrar novo Tipo de Receita'
    click_on 'Voltar'

    expect(current_path).to eq(root_path)
  end

  scenario 'going to cuisine registering and back' do
    setup_data

    visit root_path
    click_on 'Cadastrar nova Cozinha'
    click_on 'Voltar'

    expect(current_path).to eq(root_path)
  end

  scenario 'going to list registering and back' do
    setup_data

    visit root_path
    click_on 'Adicionar nova Lista'
    click_on 'Voltar'

    expect(current_path).to eq(root_path)
  end
  
  def setup_data
    user = create(:user)

    recipe = create(:recipe, title: 'Receita de Farinha', cuisine: create(:cuisine),
      recipe_type: create(:recipe_type), user: user, difficulty: 'Fácil',
      cook_time: 100, ingredients: 'Farinha', cook_method: 'Cozinhar')
    
    login_as(user, scope: :user)
    return user
  end
end