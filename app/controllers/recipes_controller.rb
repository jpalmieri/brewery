class RecipesController < ApplicationController
  before_action :authenticate_user!, except: :show

  def new
    @recipe = Recipe.new
  end

  def create
    @recipe = current_user.recipes.create(recipe_params)
    if @recipe.save
      flash[:notice] = "Recipe saved."
      redirect_to @recipe
    else
      error_list = "<ul>"
      @recipe.errors.full_messages.each do |error|
        error_list += "<li>#{error}</li>"
      end
      error_list += "</ul>"
      flash[:error] = "There was an error saving your recipe: #{error_list}"
      render :new
    end
  end

  def edit
    if current_user.id == Recipe.find(params[:id]).user.id
      @recipe = current_user.recipes.find(params[:id])
    else
      flash[:error] = "You are not authorized to edit this recipe."
      redirect_to root_path
    end
  end

  def update
    if current_user.id == Recipe.find(params[:id]).user.id
      @recipe = current_user.recipes.find(params[:id])
      if @recipe.update_attributes(recipe_params)
        flash[:notice] = "Recipe updated."
        redirect_to @recipe
      else
        flash[:error] = "There was an error saving your recipe."
        render :edit
      end
    else
      flash[:error] = "You are not authorized to update this recipe."
      redirect_to root_path
    end
  end

  def show
    @recipe = Recipe.find(params[:id])
  end

  private

  def recipe_params
    params.require(:recipe).permit(
      :name,
      :style,
      :yeast,
      :summary,
      :notes,
      :batch_size,
      grains_attributes: [:name, :weight, :id],
      hops_attributes: [:name, :weight, :boil_time, :id],
      yeasts_attributes: [:name, :attenuation, :id]
    )
  end
end
