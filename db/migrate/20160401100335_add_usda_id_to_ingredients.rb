class AddUsdaIdToIngredients < ActiveRecord::Migration
  def up
    add_column :ingredients, :usda_id, :string
  end

  def down
    remove_column :ingredients, :usda_id
  end
end
