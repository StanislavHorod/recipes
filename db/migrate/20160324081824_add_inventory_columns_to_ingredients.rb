class AddInventoryColumnsToIngredients < ActiveRecord::Migration
  def up
    add_column :ingredients, :note, :string
  end

  def down
    remove_column :ingredients, :note
  end
end
