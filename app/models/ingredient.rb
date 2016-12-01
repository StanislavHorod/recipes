# Ingredient model
class Ingredient < ActiveRecord::Base
  belongs_to :user
  has_many :ingredient_quantities,
           class_name: 'RecipeIngredientsQuantity',
           dependent: :destroy
  has_many :recipes, through: :ingredient_quantities
  has_many :usda_units_coefficients, dependent: :destroy
  belongs_to :unit_type
  has_many :ingredient_unit_costs, dependent: :destroy

  validates_presence_of :name, :user, :unit_type

  before_save :squish_name
  around_create :check_for_similar_record

  def get_units
    if unit_type.name == 'USDA'
      ingredient_units = usda_units_coefficients.map(&:unit_id)
      Unit.where(id: ingredient_units)
    else
      unit_type.units
    end
  end

  def create_coefficients
    food = UsdaNutrientDatabase::Food.find_by(nutrient_databank_number: usda_id)
    return if food.blank?
    food.weights.each do |w|
      unit = Unit.find_by(
        name: w.measurement_description,
        unit_type_id: UnitType.find_by(name: 'USDA').id
      )
      coeff = w.amount / w.gram_weight

      UsdaUnitsCoefficient.find_or_create_by(
        ingredient_id: id,
        unit_id: unit.id,
        coefficient: coeff
      )
    end

    gram_unit = Unit.find_by(name: 'gram')
    UsdaUnitsCoefficient.find_or_create_by(
      ingredient_id: id,
      unit_id: gram_unit.id,
      coefficient: 1
    )
  end

  scope :user_id, -> (id) { where(user: id) }
  scope :name_is_like, -> (name) do
    t = arel_table
    where(t[:name].matches(name.squish))
  end

  private

  def squish_name
    name.squish!
  end

  def check_for_similar_record
    ingredient = Ingredient.user_id(user_id).name_is_like(name).first
    if ingredient
      self.id = ingredient.id
      return true
    else
      yield
    end
  end
end
