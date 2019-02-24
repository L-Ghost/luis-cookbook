class Cuisine < ApplicationRecord
  validates :name,
    presence: {message: 'Você precisa informar o nome da Cozinha'},
    uniqueness: {message: 'Já existe uma Cozinha com o nome informado'}
end
