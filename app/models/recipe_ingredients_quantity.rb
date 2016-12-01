# Model for ingredients quantity in recipe
class RecipeIngredientsQuantity < ActiveRecord::Base
  belongs_to :recipe
  belongs_to :ingredient
  belongs_to :unit

  accepts_nested_attributes_for :ingredient, reject_if: :all_blank

  validates_presence_of :quantity, :recipe, :ingredient, :unit

  around_destroy :remove_useless_ingredients

  private

  def reject_recipe_ingredients_quantity(attributes)
    attributes[:quantity].blank? ||
        attributes[:quantity] == 0 ||
        attributes[:unit_id].blank?
  end

  def remove_useless_ingredients
    ingredient_id = self.ingredient.id
    yield
    ingredient = Ingredient.find_by(id: ingredient_id)
    ingredient.destroy if ingredient.recipes.count == 0
  end
end
