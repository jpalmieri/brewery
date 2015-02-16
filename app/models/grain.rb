class Grain < ActiveRecord::Base
  belongs_to :recipe
  validates :name, presence: true
  validates :weight, presence: true

  def blank?
    weight.blank? && name.blank?
  end
end
