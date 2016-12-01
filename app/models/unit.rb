# Unit model
class Unit < ActiveRecord::Base
  belongs_to :unit_type
  has_many :usda_units_coefficients
  has_many :recipe_ingredients_quantities
  has_many :ingredient_unit_costs

  scope :by_type, -> (id) { where unit_type_id: id }
end
