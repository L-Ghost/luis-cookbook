class Recipe < ApplicationRecord
  belongs_to :recipe_type
  belongs_to :cuisine
  
  validates :title, :difficulty, :recipe_type_id,
    :cuisine_id, :cook_time, :ingredients,
    :cook_method, presence: true
  validates :title, uniqueness: {message: 'Já existe uma receita cadastrada com este nome'}
  
  has_one_attached :photo
  
  def cook_time_min
    "#{cook_time} minutos"
  end
end
