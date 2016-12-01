# Additional actions for units
class UnitsController < ApplicationController
  def get_units_by_ingredient
    units = Ingredient.find_by(
      user: current_user,
      name: params[:ingredient_name]
    ).get_units
    render json: { units: units }
  end

  def get_units_from_usda
    food = UsdaNutrientDatabase::Food.find_by(nutrient_databank_number: params[:id])
    units = Unit.where(name: 'gram', unit_type_id: UnitType.find_by(name: 'USDA').id)
    food.weights.map(&:measurement_description).each do |name|
      units.append Unit.find_or_create_by(name: name, unit_type_id: UnitType.find_by(name: 'USDA').id)
    end
    render json: { units: units }
  end
end
