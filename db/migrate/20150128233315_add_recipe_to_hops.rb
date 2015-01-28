class AddRecipeToHops < ActiveRecord::Migration
  def change
    add_reference(:hops, :recipe)
  end
end
