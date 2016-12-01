# Model for ingredients costs
class IngredientUnitCost < ActiveRecord::Base
  belongs_to :ingredient
  belongs_to :unit
end
