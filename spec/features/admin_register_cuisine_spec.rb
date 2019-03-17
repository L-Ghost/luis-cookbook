require 'rails_helper'

feature 'Admin register Cuisine' do
  scenario 'successfully' do
    setup_user
    visit root_path
    click_on 'Cadastrar nova Cozinha'
    
    expect(page).to have_css('h1', text: 'Cadastro de Cozinhas')

    fill_in 'Nome', with: 'Brasileira'
    click_on 'Enviar'

    expect(page).to have_css('h1', text: 'Brasileira')
  end

  scenario 'and must fill in name' do
    setup_user
    visit root_path
    click_on 'Cadastrar nova Cozinha'

    fill_in 'Nome', with: ''
    click_on 'Enviar'
    
    expect(page).to have_css('h2', text: 'Não foi possível salvar a Cozinha')
    expect(page).to have_content('Você precisa informar o nome da Cozinha')
    expect(Cuisine.count).to eq(0)
  end

  scenario 'and must not repeat cuisine names' do
    setup_user
    visit root_path
    click_on 'Cadastrar nova Cozinha'
    fill_in 'Nome', with: 'Portuguesa'
    click_on 'Enviar'

    visit root_path
    click_on 'Cadastrar nova Cozinha'
    fill_in 'Nome', with: 'Portuguesa'
    click_on 'Enviar'
    
    expect(page).to have_css('h2', text: 'Não foi possível salvar a Cozinha')
    expect(page).to have_content('Já existe uma Cozinha com o nome informado')
    expect(Cuisine.count).to eq(1)
  end

  scenario 'but gets redirect to login' do
    visit new_cuisine_path

    expect(current_path).to eq(new_user_session_path)
  end

  # create data for login
  def setup_user
    user = create(:user)
    login_as(user, scope: :user)
  end  
end