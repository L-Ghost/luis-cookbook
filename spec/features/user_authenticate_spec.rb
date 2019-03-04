require 'rails_helper'

feature 'User Authenticate' do
  
  scenario 'not logged in' do
    visit root_path

    expect(page).to have_link('Login')
    expect(page).not_to have_link('Logout')
  end

  scenario 'logged in' do
    user = setup_user
    login_as(user, scope: :user)
    visit root_path

    expect(page).not_to have_link('Login')
    expect(page).to have_link('Logout')
  end

  scenario 'successfully' do
    user = setup_user
    visit root_path

    click_on 'Login'
    fill_in 'Email', with: user.email
    fill_in 'Senha', with: user.password
    within 'form' do
      click_on 'Login'
    end
    
    expect(current_path).to eq(root_path)
    expect(page).not_to have_link('Login')
    expect(page).to have_link('Logout')
    expect(page).to have_css('p', text: "Logado como #{user.email}")
  end

  scenario 'and logout' do
    user = setup_user
    login_as(user, scope: :user)
    visit root_path

    click_on 'Logout'

    expect(current_path).to eq(root_path)
    expect(page).to have_link('Login')
    expect(page).not_to have_link('Logout')
    expect(page).not_to have_css('p', text: "Logado como #{user.email}")
  end

  def setup_user
    User.create!(email: 'emailtest@cookbook.com', password: 't3stp4ssw0rd')
  end
end