class ChangePrecisionAndScaleOfAttenuation < ActiveRecord::Migration
  def change
    def self.up
      change_column :yeasts, :attenuation, :decimal, :precision => 4 , :scale => 2
    end
  end
end
