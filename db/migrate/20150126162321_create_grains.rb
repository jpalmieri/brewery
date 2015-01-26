class CreateGrains < ActiveRecord::Migration
  def change
    create_table :grains do |t|
      t.string :name
      t.decimal :weight, precision: 4, scale: 2

      t.timestamps null: false
    end
  end
end
