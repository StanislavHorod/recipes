# Group model
class Group < ActiveRecord::Base
  belongs_to :user
  has_many :recipe_quantities, class_name: 'GroupRecipesQuantity', dependent: :destroy
  has_many :recipes, through: :recipe_quantities
  has_many :appetite_size_quantities, dependent: :destroy
  has_many :appetite_sizes, through: :appetite_size_quantities

  accepts_nested_attributes_for :appetite_size_quantities, reject_if: proc { |attributes| attributes[:quantity].blank? || attributes[:quantity] == 0 }, allow_destroy: true
  accepts_nested_attributes_for :recipe_quantities, reject_if: proc { |attributes| attributes[:quantity].blank? || attributes[:quantity] == 0 }, allow_destroy: true

  validates_presence_of :name

  def with_size(size)
    asq = self.appetite_size_quantities.find_by(appetite_size: size)
    asq = size.appetite_size_quantities.build unless asq.present?
    asq
  end

  def with_recipe(recipe)
    rq = self.recipe_quantities.where(recipe: recipe)
    rq = recipe.group_recipes_quantities.build unless rq.present?
    rq
  end
end
