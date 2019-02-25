class RecipesController < ApplicationController
  
  def index
    @recipes = Recipe.all
  end

  def show
    @recipe = Recipe.find(params[:id])
  end

  def new
    @recipe = Recipe.new
    @recipe_types = RecipeType.all
    @cuisines = Cuisine.all
  end

  def create
    @recipe = Recipe.new(recipe_params)
    if @recipe.save
      redirect_to @recipe
    else
      @recipe_types = RecipeType.all
      @cuisines = Cuisine.all
      render :new
    end
  end

  def edit
    @recipe = Recipe.find(params[:id])
    @recipe_types = RecipeType.all
    @cuisines = Cuisine.all
  end

  def update
    @recipe = Recipe.find(params[:id])
    if @recipe.update(recipe_params)
      redirect_to @recipe
    else
      @recipe_types = RecipeType.all
      @cuisines = Cuisine.all
      render :edit
    end
  end

  def destroy
    @recipe = Recipe.find(params[:id])
    @recipe.destroy
    redirect_to :root
  end
  
  def search
    if !params[:q].blank?
      @recipes = Recipe.where("title like ?", "%#{params[:q]}%")
    end
  end

  private

  def recipe_params
    params.require(:recipe).permit(:title, :difficulty, :recipe_type_id,
      :cuisine_id, :cook_time, :ingredients, :cook_method, :photo)
  end
  
end