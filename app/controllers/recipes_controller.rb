class RecipesController < ApplicationController

  def new
    @recipe = Recipe.new
    3.times { @recipe.grains.build }
  end

  def create
    @recipe = current_user.recipes.create(recipe_params)
    @recipe.grains.each do |grain|
      grain.weight.to_f
      grain.save
    end
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
    params.require(:recipe).permit(:name, :style, :grains, :yeast, :summary, :notes)
  end
end
