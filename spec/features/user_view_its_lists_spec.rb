require 'rails_helper'

feature 'User view its lists' do
  scenario 'through root, but needs to be authenticated' do
    visit root_path

    expect(page).not_to have_link('Minhas Listas')
  end

  scenario 'but needs to be authenticated' do
    visit my_lists_path

    expect(current_path).to eq(new_user_session_path)
  end

  scenario 'successfully' do
    setup_data
    visit root_path
    click_on 'Minhas Listas'
    
    expect(current_path).to eq(my_lists_path)
    expect(page).to have_css('h1', text: 'Minhas Listas')
    expect(page).to have_link('Tortas')
    expect(page).to have_link('Doces')
    expect(page).to have_link('Festa Junina')
    expect(page).to have_css('h2', text: 'Total de Listas: 3')
  end
  
  def setup_data
    user = create(:user)
    another_user = create(:user)
    create(:list, name: 'Tortas', user: user)
    create(:list, name: 'Doces', user: user)
    create(:list, name: 'Festa Junina', user: user)
    create(:list, name: 'Bolos', user: another_user)
    login_as(user, scope: :user)
  end
end