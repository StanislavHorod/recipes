# Model for ingredients with usda unit type
class UsdaUnitsCoefficient < ActiveRecord::Base
  belongs_to :unit
  belongs_to :ingredient
end
