class Yeast < ActiveRecord::Base
  belongs_to :recipe

  validates_presence_of :name
  validates_numericality_of :attenuation
end
