class RemoveRecipeTypeAndCuisineFromRecipe < ActiveRecord::Migration[5.2]
  def change
    remove_column :recipes, :recipe_type, :string
    remove_column :recipes, :cuisine, :string
  end
end
