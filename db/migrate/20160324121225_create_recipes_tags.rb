class CreateRecipesTags < ActiveRecord::Migration
  def up
    create_join_table :recipes, :tags
  end

  def down
    drop_join_table :recipes, :tags
  end
end
