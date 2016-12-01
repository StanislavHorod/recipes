class CreateUnitTypes < ActiveRecord::Migration
  def up
    create_table :unit_types do |t|
      t.string :name, null: false
    end
    add_reference :units, :unit_type, index: true
  end

  def down
    remove_reference :units, :unit_type
    drop_table :unit_types
  end
end
