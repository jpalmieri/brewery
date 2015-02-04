class CreateYeasts < ActiveRecord::Migration
  def change
    create_table :yeasts do |t|
      t.references :recipe, index: true
      t.string :name
      t.decimal :attenuation, precision: 4, scale: 3

      t.timestamps null: false
    end
    add_foreign_key :yeasts, :recipes
  end
end
