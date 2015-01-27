class Recipe < ActiveRecord::Base
  belongs_to :user
  has_many :grains, dependent: :destroy
  accepts_nested_attributes_for :grains, reject_if: proc { |attributes| attributes['name'].blank? || attributes['weight'].blank? }

  validates :name, presence: true
  validates :user_id, presence: true
  validates_presence_of :grains,  message: "must include name and weight of at least one grain"
  
end
