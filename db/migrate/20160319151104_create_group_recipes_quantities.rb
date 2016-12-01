class CreateGroupRecipesQuantities < ActiveRecord::Migration
  def change
    create_table :group_recipes_quantities do |t|
      t.belongs_to :group, index: true, foreign_key: true, null: false
      t.belongs_to :recipe, index: true, foreign_key: true, null: false
      t.integer :quantity, null: false
    end
  end
end
