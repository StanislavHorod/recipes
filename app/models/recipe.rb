# Recipe model
class Recipe < ActiveRecord::Base
  belongs_to :user
  has_many :ingredient_quantities,
           class_name: 'RecipeIngredientsQuantity',
           dependent: :destroy
  has_many :ingredients, through: :ingredient_quantities
  has_and_belongs_to_many :meal_components
  has_and_belongs_to_many :meal_categories
  has_and_belongs_to_many :tags
  has_many :group_recipes_quantities, dependent: :destroy

  accepts_nested_attributes_for :ingredient_quantities,
                                reject_if: :all_blank,
                                allow_destroy: true
  accepts_nested_attributes_for :ingredients

  validates_presence_of :name, :servings_count

  scope :by_categories, -> (ids) { includes(:meal_categories).where(meal_categories: { id: ids }) }
  scope :by_components, -> (ids) { includes(:meal_components).where(meal_components: { id: ids }) }
  scope :by_tags, -> (ids) { includes(:tags).where(tags: {id: ids}) }
  scope :in_group, -> (id) { includes(:group_recipes_quantities).where(group_recipes_quantities: { group_id: id }) }

  def update_categories(categories)
    for_delete = meal_categories - categories
    for_delete.each { |c| meal_categories.delete(c) }
    categories.each do |c|
      meal_categories.append(c) unless meal_categories.find_by(id: c.id)
    end
  end

  def update_components(components)
    for_delete = meal_components - components
    for_delete.each { |c| meal_components.delete(c) }
    components.each do |c|
      meal_components.append(c) unless meal_components.find_by(id: c.id)
    end
  end

  def update_tags(tags)
    for_delete = self.tags - tags
    for_delete.each do |t|
      self.tags.delete(t)
      t.destroy if t.recipes.blank?
    end
    tags.each do |tag|
      self.tags.append(tag) unless self.tags.find_by(id: tag.id)
    end
  end

  def create_coefficients_for_usda_ingredients
    ingredients.each(&:create_coefficients)
  end
end
