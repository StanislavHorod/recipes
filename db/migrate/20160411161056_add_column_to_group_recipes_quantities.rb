class AddColumnToGroupRecipesQuantities < ActiveRecord::Migration
  def up
    add_column :group_recipes_quantities, :individuals_served, :integer
  end

  def down
    remove_column :group_recipes_quantities, :individuals_served
  end
end
