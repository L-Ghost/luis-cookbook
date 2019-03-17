class RecipesController < ApplicationController
  before_action :authenticate_user!, only: [:new, :edit, :my]

  def index
    @recipes = Recipe.all
  end

  def show
    @recipe = Recipe.find(params[:id])
    @lists = List.all
  end

  def new
    @recipe = Recipe.new
    @recipe_types = RecipeType.all
    @cuisines = Cuisine.all
  end

  def create
    @recipe = Recipe.new(recipe_params)
    @recipe.user = current_user
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
    redirect_to root_path if @recipe.user != current_user
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
    if !params[:q].nil?
      @recipes = Recipe.where("title like ?", "%#{params[:q]}%")
    end
  end

  def my
    @recipes = Recipe.where(user: current_user)
  end

  def favorite
    @recipe = Recipe.find(params[:id])
    @recipe.update(favorite: true)
    redirect_to @recipe
  end

  def unfavorite
    @recipe = Recipe.find(params[:id])
    @recipe.update(favorite: false)
    redirect_to @recipe
  end

  def add_to_list
    @recipe = Recipe.find(params[:id])
    @list = List.find(params[:list_id])
    ListRecipe.create(list: @list, recipe: @recipe)
    redirect_to @recipe
  end
  
  private

  def recipe_params
    params.require(:recipe).permit(:title, :difficulty, :recipe_type_id,
      :cuisine_id, :cook_time, :ingredients, :cook_method, :photo)
  end
  
end