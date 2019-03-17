class List < ApplicationRecord
  belongs_to :user
  has_many :list_recipes
  has_many :recipes, through: :list_recipes

  validates :name, presence: {message: "Você precisa informar o nome da Lista"}
  validates :name, uniqueness:
    {scope: [:name, :user], message: "Já existe uma Lista com o nome informado"}
end
