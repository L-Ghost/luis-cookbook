class List < ApplicationRecord
  belongs_to :user

  validates :name, presence: {message: "Você precisa informar o nome da Lista"}
  validates :name, uniqueness:
    {scope: [:name, :user], message: "Já existe uma Lista com o nome informado"}
end
