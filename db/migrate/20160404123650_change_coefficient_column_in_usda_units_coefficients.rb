class ChangeCoefficientColumnInUsdaUnitsCoefficients < ActiveRecord::Migration
  def up
    change_column :usda_units_coefficients, :coefficient, :float
  end

  def down
    change_column :usda_units_coefficients, :coefficient, :integer
  end
end
