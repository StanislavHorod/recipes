class AddColumnsToGroups < ActiveRecord::Migration
  def up
    add_column :groups, :total_individuals, :integer
    add_column :groups, :total_servings, :float
  end

  def down
    remove_column :groups, :total_individuals
    remove_column :groups, :total_servings
  end
end
