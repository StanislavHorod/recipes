# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


UnitType.find_or_create_by(name: 'Unconvertable')
UnitType.find_or_create_by(name: 'Weight')
UnitType.find_or_create_by(name: 'Volume')
UnitType.find_or_create_by(name: 'USDA')

Unit.find_or_create_by(unit_type_id: UnitType.find_by(name: 'Unconvertable').id, name: 'whole', coefficient: 1)
Unit.find_or_create_by(unit_type_id: UnitType.find_by(name: 'Unconvertable').id, name: 'package', coefficient: 1)
Unit.find_or_create_by(unit_type_id: UnitType.find_by(name: 'Unconvertable').id, name: 'bag', coefficient: 1)
Unit.find_or_create_by(unit_type_id: UnitType.find_by(name: 'Unconvertable').id, name: 'box', coefficient: 1)
Unit.find_or_create_by(unit_type_id: UnitType.find_by(name: 'Unconvertable').id, name: 'can', coefficient: 1)
Unit.find_or_create_by(unit_type_id: UnitType.find_by(name: 'Unconvertable').id, name: 'jar', coefficient: 1)

Unit.find_or_create_by(unit_type_id: UnitType.find_by(name: 'Weight').id, name: 'pinch', coefficient: 0.3)
Unit.find_or_create_by(unit_type_id: UnitType.find_by(name: 'Weight').id, name: 'ounce', coefficient: 28.4)
Unit.find_or_create_by(unit_type_id: UnitType.find_by(name: 'Weight').id, name: 'pound', coefficient: 453.6)
Unit.find_or_create_by(unit_type_id: UnitType.find_by(name: 'Weight').id, name: 'gram', coefficient: 1)
Unit.find_or_create_by(unit_type_id: UnitType.find_by(name: 'Weight').id, name: 'kilogram', coefficient: 1000)

Unit.find_or_create_by(unit_type_id: UnitType.find_by(name: 'Volume').id, name: 'cup', coefficient: 236.6)
Unit.find_or_create_by(unit_type_id: UnitType.find_by(name: 'Volume').id, name: '1/2 cup', coefficient: 118.3)
Unit.find_or_create_by(unit_type_id: UnitType.find_by(name: 'Volume').id, name: '1/4 cup', coefficient: 59.1)
Unit.find_or_create_by(unit_type_id: UnitType.find_by(name: 'Volume').id, name: '1/8 cup', coefficient: 29.6)
Unit.find_or_create_by(unit_type_id: UnitType.find_by(name: 'Volume').id, name: 'tablespoon', coefficient: 14.8)
Unit.find_or_create_by(unit_type_id: UnitType.find_by(name: 'Volume').id, name: '1/2 tablespoon', coefficient: 7.4)
Unit.find_or_create_by(unit_type_id: UnitType.find_by(name: 'Volume').id, name: 'teaspoon', coefficient: 4.9)
Unit.find_or_create_by(unit_type_id: UnitType.find_by(name: 'Volume').id, name: '1/2 teaspoon', coefficient: 2.5)
Unit.find_or_create_by(unit_type_id: UnitType.find_by(name: 'Volume').id, name: '1/4 teaspoon', coefficient: 1.2)
Unit.find_or_create_by(unit_type_id: UnitType.find_by(name: 'Volume').id, name: 'fluid ounce', coefficient: 29.6)
Unit.find_or_create_by(unit_type_id: UnitType.find_by(name: 'Volume').id, name: 'liter', coefficient: 1000)
Unit.find_or_create_by(unit_type_id: UnitType.find_by(name: 'Volume').id, name: 'milliliters', coefficient: 1)
Unit.find_or_create_by(unit_type_id: UnitType.find_by(name: 'Volume').id, name: 'gallon', coefficient: 3785.4)
Unit.find_or_create_by(unit_type_id: UnitType.find_by(name: 'Volume').id, name: 'quart', coefficient: 946.4)
Unit.find_or_create_by(unit_type_id: UnitType.find_by(name: 'Volume').id, name: 'pint', coefficient: 473.2)

Unit.find_or_create_by(unit_type_id: UnitType.find_by(name: 'USDA').id, name: 'gram', coefficient: 1)


MealCategory.find_or_create_by(name: 'Vegan')
MealCategory.find_or_create_by(name: 'Cakes & Pies')
MealCategory.find_or_create_by(name: 'Casseroles')
MealCategory.find_or_create_by(name: 'Breakfast & Brunch')
MealCategory.find_or_create_by(name: 'Appetizers')
MealCategory.find_or_create_by(name: 'Desserts')
MealCategory.find_or_create_by(name: 'Dips & Salsas')
MealCategory.find_or_create_by(name: 'Drinks')
MealCategory.find_or_create_by(name: 'Entrees')
MealCategory.find_or_create_by(name: 'Salads')
MealCategory.find_or_create_by(name: 'Sandwiches')
MealCategory.find_or_create_by(name: 'Snacks')
MealCategory.find_or_create_by(name: 'Soup, Stews & Chili')

MealComponent.find_or_create_by(name: 'Eggs')
MealComponent.find_or_create_by(name: 'Fish')
MealComponent.find_or_create_by(name: 'Soy')
MealComponent.find_or_create_by(name: 'Nuts')
MealComponent.find_or_create_by(name: 'Meat')