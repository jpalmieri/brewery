class RemoveYeastFromRecipe < ActiveRecord::Migration
  def change
    remove_column :recipes, :yeast
  end
end
