class Grain < ActiveRecord::Base
  belongs_to :recipe
  validates :name, presence: true
  validates :weight, presence: true
end
