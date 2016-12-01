class ChangeIntToFloatIngredientQuantity < ActiveRecord::Migration
  def up
    change_column :recipe_ingredients_quantities, :quantity, :float
  end

  def down
    change_column :recipe_ingredients_quantities, :quantity, :integer
  end
end
