class CreateMealCategoriesRecipes < ActiveRecord::Migration
  def up
    create_join_table :meal_categories, :recipes
  end

  def down
    drop_join_table :meal_categories, :recipes
  end
end
