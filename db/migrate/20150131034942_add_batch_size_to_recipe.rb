class AddBatchSizeToRecipe < ActiveRecord::Migration
  def change
    add_column :recipes, :batch_size, :float, {precision: 4, scale: 2}
  end
end
