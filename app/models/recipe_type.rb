class RecipeType < ApplicationRecord
  validates :name,
    presence: {message: 'Você precisa informar o nome do Tipo de Receita'},
    uniqueness: {message: 'Já existe um Tipo de Receita com o nome informado'}
end
