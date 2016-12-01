class AddUnitAndPriceColumnsToIngredients < ActiveRecord::Migration
  def up
    add_reference :ingredients, :unit_type, index: true
    # add_reference :ingredients, :unit, index: true
    # add_column :ingredients, :price, :float
  end

  def down
    remove_reference :ingredients, :unit_type
    # remove_reference :ingredients, :unit
    # remove_column :ingredients, :price
  end
end
