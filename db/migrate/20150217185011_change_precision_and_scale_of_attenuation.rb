class ChangePrecisionAndScaleOfAttenuation < ActiveRecord::Migration
  def change
    change_column :yeasts, :attenuation, :decimal, { :precision => 4 , :scale => 2 }
  end
end
