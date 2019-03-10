require 'rails_helper'

feature 'Admin register Cuisine' do
  scenario 'successfully' do
    setup_user
    visit root_path
    click_on 'Adicionar nova Lista'
    
    expect(page).to have_css('h1', text: 'Adicionar Listas')

    fill_in 'Nome', with: 'Festa Junina'
    click_on 'Enviar'

    expect(page).to have_css('h1', text: 'Festa Junina')
  end
  
  scenario 'and must fill in name' do
    setup_user
    visit root_path
    click_on 'Adicionar nova Lista'

    fill_in 'Nome', with: ''
    click_on 'Enviar'
    
    expect(page).to have_css('h2', text: 'Não foi possível salvar a Lista')
    expect(page).to have_content('Você precisa informar o nome da Lista')
    expect(List.count).to eq(0)
  end

  scenario 'and must not repeat list names' do
    setup_user
    visit root_path
    click_on 'Adicionar nova Lista'
    fill_in 'Nome', with: 'Natal'
    click_on 'Enviar'

    visit root_path
    click_on 'Adicionar nova Lista'
    fill_in 'Nome', with: 'Natal'
    click_on 'Enviar'
    
    expect(page).to have_css('h2', text: 'Não foi possível salvar a Lista')
    expect(page).to have_content('Já existe uma Lista com o nome informado')
    expect(List.count).to eq(1)
  end

  scenario 'with the same name as another user' do
    setup_user
    setup_another_user
    visit root_path
    click_on 'Adicionar nova Lista'

    fill_in 'Nome', with: 'Doces'
    click_on 'Enviar'

    expect(page).to have_css('h1', text: 'Doces')
    expect(List.count).to eq(2)
  end

  scenario 'but gets redirect to login' do
    visit new_list_path

    expect(current_path).to eq(new_user_session_path)
  end

  # create data for test
  def setup_user
    user = User.create!(email: 'emailtest@cookbook.com', password: 't3stp4ssw0rd')
    login_as(user, scope: :user)
  end

  def setup_another_user
    another_user = User.create!(email: 'emailtest2@cookbook.com', password: 't4stp3ssw0rd')
    List.create!(name: 'Doces', user: another_user)
  end
end