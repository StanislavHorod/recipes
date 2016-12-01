class CreateRecipeIngredientsQuantities < ActiveRecord::Migration
  def change
    create_table :recipe_ingredients_quantities do |t|
      t.belongs_to :ingredient, index: true, foreign_key: true, null: false
      t.belongs_to :recipe, index: true, foreign_key: true, null: false
      t.integer :quantity, null: false
    end
  end
end
