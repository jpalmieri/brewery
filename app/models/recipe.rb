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

  accepts_nested_attributes_for :grains, reject_if: proc { |attributes| attributes['name'].blank? && attributes['weight'].blank? }
  accepts_nested_attributes_for :hops, reject_if: proc { |attributes| attributes['name'].blank? && attributes['weight'].blank? }

  validates :name, presence: true
  validates :user_id, presence: true
  validates_presence_of :grains,  message: "must include name and weight of at least one grain"
  validates_presence_of :hops,  message: "must include name and weight of at least one hop"
  
end
