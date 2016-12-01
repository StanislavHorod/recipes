# UnitType model
class UnitType < ActiveRecord::Base
  has_many :units
  has_many :ingredients
end
