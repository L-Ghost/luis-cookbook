require 'rails_helper'

feature 'Admin register Recipe Type' do
  
  scenario 'successfully' do
    setup_user
    visit root_path
    click_on 'Cadastrar novo Tipo de Receita'
    
    expect(page).to have_css('h1', text: 'Cadastro de Tipos de Receita')

    fill_in 'Nome', with: 'Lanche'
    click_on 'Enviar'

    expect(page).to have_css('h1', text: 'Lanche')
  end

  scenario 'and must fill in name' do
    setup_user
    visit root_path
    click_on 'Cadastrar novo Tipo de Receita'

    fill_in 'Nome', with: ''
    click_on 'Enviar'
    
    expect(page).to have_css('h2', text: 'Não foi possível salvar o Tipo de Receita')
    expect(page).to have_content('Você precisa informar o nome do Tipo de Receita')
    expect(RecipeType.count).to eq(0)
  end

  scenario 'and must not repeat names' do
    setup_user
    visit root_path
    click_on 'Cadastrar novo Tipo de Receita'
    fill_in 'Nome', with: 'Sobremesa'
    click_on 'Enviar'

    visit root_path
    click_on 'Cadastrar novo Tipo de Receita'
    fill_in 'Nome', with: 'Sobremesa'
    click_on 'Enviar'
    
    expect(page).to have_css('h2', text: 'Não foi possível salvar o Tipo de Receita')
    expect(page).to have_content('Já existe um Tipo de Receita com o nome informado')
    expect(RecipeType.count).to eq(1)
  end

  scenario 'but gets redirect to login' do
    visit new_recipe_type_path

    expect(current_path).to eq(new_user_session_path)
  end

  # create data for login
  def setup_user
    user = User.create!(email: 'emailtest@cookbook.com', password: 't3stp4ssw0rd')
    login_as(user, scope: :user)
  end
end