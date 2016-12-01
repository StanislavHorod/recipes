class CreateAppetiteSizes < ActiveRecord::Migration
  def up
    create_table :appetite_sizes do |t|
      t.string :name, null: false
      t.float :coefficient, null: false
    end
  end

  def down
    drop_table :appetite_sizes
  end
end
