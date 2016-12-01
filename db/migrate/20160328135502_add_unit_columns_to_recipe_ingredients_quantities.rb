class AddUnitColumnsToRecipeIngredientsQuantities < ActiveRecord::Migration
  def up
    add_reference :recipe_ingredients_quantities, :unit, index: true
  end

  def down
    remove_reference :recipe_ingredients_quantities, :unit
  end
end
