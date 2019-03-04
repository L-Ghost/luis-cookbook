require 'rails_helper'

feature 'User register recipe' do
  scenario 'successfully' do
    setup_data
    visit root_path
    click_on 'Cadastrar nova Receita'
    
    expect(page).to have_css('h1', text: 'Cadastro de Receitas')

    fill_in 'Nome', with: 'Pão de Queijo de Beterraba'
    fill_in 'Dificuldade', with: 'Médio'
    select 'Entrada', from: 'Tipo da Receita'
    select 'Brasileira', from: 'Cozinha'
    fill_in 'Tempo de Preparo', with: 40
    fill_in 'Ingredientes', with: '1 batata média cozida, 1 beterraba cozida, 1/2 xícara de polvilho azedo, 2 colheres de sopa de azeite, 1 olher de chá de sal, 1/2 colher de levedo de cerveja (opcional)'
    fill_in 'Modo de Preparo', with: 'Amasse a batata e a beterraba ainda quentes até quase virar um purê. Em seguida adicione o azeite, levedo de cerveja, sal e misture bem. Adicione o polvilho azedo e o doce...'
    attach_file 'Foto', Rails.root.join('spec', 'support', 'pdqdb.jpeg') # Renata picture

    click_on 'Enviar'

    expect(page).to have_css('h1', text: 'Pão de Queijo de Beterraba')
    expect(page).to have_css('h3', text: 'Detalhes')
    expect(page).to have_css('p', text: 'Médio')
    expect(page).to have_css('p', text: 'Entrada')
    expect(page).to have_css('p', text: 'Brasileira')
    expect(page).to have_css('p', text: '40 minutos')

    expect(page).to have_css('h3', text: 'Ingredientes')
    expect(page).to have_css('p', text: '1 batata média cozida, 1 beterraba cozida, 1/2 xícara de polvilho azedo, 2 colheres de sopa de azeite, 1 olher de chá de sal, 1/2 colher de levedo de cerveja (opcional)')
    expect(page).to have_css('h3', text: 'Como Preparar')
    expect(page).to have_css('p', text: 'Amasse a batata e a beterraba ainda quentes até quase virar um purê. Em seguida adicione o azeite, levedo de cerveja, sal e misture bem. Adicione o polvilho azedo e o doce...')
    expect(page).to have_css('img[src*="pdqdb.jpeg"]')
    expect(page).to have_css('p', text: "Enviado por: emailtest@cookbook.com")
  end

  scenario 'and leave some fields blank' do
    setup_data
    visit root_path
    click_on 'Cadastrar nova Receita'
    
    fill_in 'Nome', with: ''
    fill_in 'Dificuldade', with: ''
    fill_in 'Tempo de Preparo', with: ''
    fill_in 'Ingredientes', with: ''
    fill_in 'Modo de Preparo', with: ''

    click_on 'Enviar'

    expect(page).to have_content('Não foi possível salvar a Receita')
    expect(Recipe.count).to eq(0)
  end

  scenario 'and cannot repeat recipe name' do
    setup_data
    visit root_path
    click_on 'Cadastrar nova Receita'
    
    fill_in 'Nome', with: 'Peixinho da Horta'
    fill_in 'Dificuldade', with: 'Fácil'
    select 'Prato Principal', from: 'Tipo da Receita'
    select 'Portuguesa', from: 'Cozinha'
    fill_in 'Tempo de Preparo', with: 30
    fill_in 'Ingredientes', with: 'Folhas de Stachys Bizantina, 1/4 de xícara de farinha de trigo, 1/4 de xícara de fubá...'
    fill_in 'Modo de Preparo', with: 'Lave bem as folhas do peixinho da horta e seque-as muito bem com um pano de prato limpo ou papel toalha...'

    click_on 'Enviar'
    click_on 'Voltar'
    click_on 'Cadastrar nova Receita'
    
    fill_in 'Nome', with: 'Peixinho da Horta'
    fill_in 'Dificuldade', with: 'Fácil'
    select 'Prato Principal', from: 'Tipo da Receita'
    select 'Portuguesa', from: 'Cozinha'
    fill_in 'Tempo de Preparo', with: 30
    fill_in 'Ingredientes', with: 'Folhas de Stachys Bizantina, 1/4 de xícara de farinha de trigo, 1/4 de xícara de fubá...'
    fill_in 'Modo de Preparo', with: 'Lave bem as folhas do peixinho da horta e seque-as muito bem com um pano de prato limpo ou papel toalha...'

    click_on 'Enviar'
    expect(page).to have_content('Não foi possível salvar a Receita')
    expect(page).to have_content('Já existe uma receita cadastrada com este nome')
    expect(Recipe.count).to eq(1)
  end

  scenario 'but gets redirect to login' do
    visit new_recipe_path

    expect(current_path).to eq(new_user_session_path)
  end
  
  # create data for validation and login
  def setup_data
    RecipeType.create(name: 'Entrada')
    RecipeType.create(name: 'Prato Principal')
    Cuisine.create(name: 'Brasileira')
    Cuisine.create(name: 'Portuguesa')

    user = User.create!(email: 'emailtest@cookbook.com', password: 't3stp4ssw0rd')
    login_as(user, scope: :user)
  end
  
end