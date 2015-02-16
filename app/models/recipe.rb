class Recipe < ActiveRecord::Base
  belongs_to :user
  has_many :grains, dependent: :destroy do
    # Return the number of open grain spots. Say we have 2 grains already
    # specified for the recipe, then `remaining_capacity` would be 1. (Assuming
    # max capacity is 3 grains).
    # More about Association Extensions:
    # http://guides.rubyonrails.org/association_basics.html#association-extensions
    def remaining_capacity
      max_capacity = 3
      max_capacity - proxy_association.target.size
    end
  end

  has_many :hops, dependent: :destroy do
    def remaining_capacity
      max_capacity = 2
      max_capacity - proxy_association.target.size
    end
  end

  has_many :yeasts, dependent: :destroy do
    def remaining_capacity
      max_capacity = 1
      max_capacity - proxy_association.target.size
    end
  end

  accepts_nested_attributes_for :grains, allow_destroy: true
  accepts_nested_attributes_for :hops, allow_destroy: true
  accepts_nested_attributes_for :yeasts, allow_destroy: true

  before_validation :reject_blank_ingredients

  validates :name, presence: true
  validates :user_id, presence: true
  validates_presence_of :grains,  message: "must include name and weight of at least one grain"
  validates_presence_of :hops,  message: "must include name and weight of at least one hop"
  validates_numericality_of :batch_size
  

  def original_gravity
    brewhouse_efficiency = 0.75
    (((37 * brewhouse_efficiency) / (batch_size / total_grain_weight)) + 1000) / 1000
  end

  def avg_attenuation
    if yeasts.first
      yeasts.average(:attenuation) / 100
    else
      0
    end
  end

  def final_gravity
    avg_attenuation + original_gravity + (-(original_gravity * avg_attenuation))
  end

  def total_grain_weight
    grains.sum(:weight)
  end

  def reject_blank_ingredients
    [grains, hops, yeasts].each do |ingredients|
      ingredients.each do |ingredient|
        if ingredient.blank?
          ingredient.mark_for_destruction
        end
      end
    end
  end

end
