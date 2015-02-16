class Hop < ActiveRecord::Base
  belongs_to :recipe
  validates :name, presence: true
  validates :weight, presence: true
  validates :boil_time, presence: true
end
