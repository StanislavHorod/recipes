class CreateIngredientUnitCosts < ActiveRecord::Migration
  def change
    create_table :ingredient_unit_costs do |t|
      t.belongs_to :ingredient, index: true, foreign_key: true, null: false
      t.belongs_to :unit, index: true, foreign_key: true, null: false
      t.float :price, null: false
    end
  end
end
