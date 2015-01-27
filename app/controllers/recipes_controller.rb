class RecipesController < ApplicationController

  def new
    @recipe = Recipe.new
    3.times { @recipe.grains.build }
  end

  def create
    @recipe = current_user.recipes.create(recipe_params)
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
    params.require(:recipe).permit(:name, :style, :yeast, :summary, :notes, grains_attributes: [:name, :weight])
  end
end
