class CreateRecipes < ActiveRecord::Migration
  def change
    create_table :recipes do |t|
      t.string :name
      t.string :style
      t.string :yeast
      t.string :summary
      t.text :notes

      t.timestamps null: false
    end
  end
end
