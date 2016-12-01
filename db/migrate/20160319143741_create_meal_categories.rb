class CreateMealCategories < ActiveRecord::Migration
  def up
    create_table :meal_categories do |t|
      t.string :name, null: false
    end
  end

  def down
    drop_table :meal_categories
  end
end
