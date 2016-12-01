class CreateUsdaUnitsCoefficients < ActiveRecord::Migration
  def change
    create_table :usda_units_coefficients do |t|
      t.belongs_to :unit, index: true, null: false
      t.belongs_to :ingredient, index: true, null: false
      t.integer :coefficient, null: false
    end
  end
end
