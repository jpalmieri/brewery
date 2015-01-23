class RecipesController < ApplicationController

  def new
    @recipe = Recipe.new
  end

  def create
    @recipe = Recipe.new(recipe_params)
    if @recipe.save
      flash[:notice] = "Recipe saved."
      redirect_to @recipe
    else
      flash[:error] = "There was an error saving your recipe: #{@recipe.errors.full_messages.first}"
      redirect_to new_recipe_path
    end
  end

  def show
    @recipe = Recipe.find(params[:id])
  end

  private

  def recipe_params
    params.require(:recipe).permit(:name, :style, :yeast, :summary, :notes)
  end
end
