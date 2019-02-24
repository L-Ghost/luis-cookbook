class Recipe < ApplicationRecord
  belongs_to :recipe_type
  belongs_to :cuisine
  
  def cook_time_min
    "#{cook_time} minutos"
  end
end
