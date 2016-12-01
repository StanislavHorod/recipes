class CreateIngredients < ActiveRecord::Migration
  def change
    create_table :ingredients do |t|
      t.string :name, null: false
      t.belongs_to :user, index: true, foreign_key: true, null: false
      t.string :store

      t.timestamps null: false
    end
  end
end
