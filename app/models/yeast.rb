class Yeast < ActiveRecord::Base
  belongs_to :recipe

  validates_presence_of :name
  validates_numericality_of :attenuation

  before_save :convert_attentuation_percentage

  private

  def convert_attentuation_percentage
    self.attenuation = attenuation.to_f/100.to_f
  end 
end
