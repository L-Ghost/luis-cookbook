require 'rails_helper'

feature 'Admin register Recipe Type' do
  
  scenario 'successfully' do
    visit root_path
    click_on 'Cadastrar novo Tipo de Receita'
    
    expect(page).to have_css('h1', text: 'Cadastro de Tipos de Receita')

    fill_in 'Nome', with: 'Lanche'
    click_on 'Enviar'

    expect(page).to have_css('h1', text: 'Lanche')
  end

  scenario 'and must fill in name' do
    visit root_path
    click_on 'Cadastrar novo Tipo de Receita'

    fill_in 'Nome', with: ''
    click_on 'Enviar'

    expect(page).to have_content('h1', text: 'Você precisa informar o nome do Tipo de Receita')
    expect(RecipeType.count).to eq(0)
  end

  scenario 'and must not repeat names' do
    visit root_path
    click_on 'Cadastrar novo Tipo de Receita'
    fill_in 'Nome', with: 'Sobremesa'
    click_on 'Enviar'

    visit root_path
    click_on 'Cadastrar novo Tipo de Receita'
    fill_in 'Nome', with: 'Sobremesa'
    click_on 'Enviar'
    
    expect(page).to have_content('h1', text: 'Já existe um Tipo de Receita com o nome informado')
    expect(RecipeType.count).to eq(1)
  end
  
end