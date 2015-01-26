class Recipe < ActiveRecord::Base
  belongs_to :user
  has_many :grains, dependent: :destroy
  accepts_nested_attributes_for :grains

  validates :name, presence: true
  validates :user_id, presence: true
  validates :grains, presence: true
  
end
