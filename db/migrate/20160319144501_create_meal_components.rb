class CreateMealComponents < ActiveRecord::Migration
  def up
    create_table :meal_components do |t|
      t.string :name, null: false
    end
  end

  def down
    drop_table :meal_components
  end
end
