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

  def setup_user
    User.create!(email: 'emailtest@cookbook.com', password: 't3stp4ssw0rd')
  end
end