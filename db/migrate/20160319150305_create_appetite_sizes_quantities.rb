class CreateAppetiteSizesQuantities < ActiveRecord::Migration
  def change
    create_table :appetite_size_quantities do |t|
      t.belongs_to :group, index: true, foreign_key: true, null: false
      t.belongs_to :appetite_size, index: true, foreign_key: true, null: false
      t.integer :quantity, null: false
    end
  end
end
