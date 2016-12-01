class CreateMealComponentsRecipes < ActiveRecord::Migration
  def up
    create_join_table :meal_components, :recipes
  end

  def down
    drop_join_table :meal_components, :recipes
  end
end
