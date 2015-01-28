class CreateHops < ActiveRecord::Migration
  def change
    create_table :hops do |t|
      t.string :name
      t.decimal :weight, precision: 4, scale: 2

      t.timestamps null: false
    end
  end
end
