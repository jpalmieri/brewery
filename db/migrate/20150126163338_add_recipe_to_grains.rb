class AddRecipeToGrains < ActiveRecord::Migration
  def change
    add_reference(:grains, :recipe)
  end
end
