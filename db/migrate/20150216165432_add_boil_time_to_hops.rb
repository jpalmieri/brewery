class AddBoilTimeToHops < ActiveRecord::Migration
  def change
    add_column :hops, :boil_time, :integer
  end
end
