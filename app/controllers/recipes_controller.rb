# Actions for recipes
class RecipesController < ApplicationController
  load_and_authorize_resource
  autocomplete :ingredient, :name, extra_data: [:store, :usda_id, :unit_type_id]
  before_action :set_recipe, only: [:edit, :update, :destroy]
  before_action :set_items_for_recipe, only: [:new, :edit, :update, :create]

  def index
    @recipes = current_user.recipes.order(:name)
    filtering_params(params).each do |key, value|
      @recipes = @recipes.public_send(key, value) if value.present?
    end
    @categories = MealCategory.where.not(id: params[:by_categories]).order(:name)
    @selected_categories = MealCategory.where(id: params[:by_categories])
    @tags = current_user.tags.where.not(id: params[:by_tags]).order(:name)
    @selected_tags = Tag.where(id: params[:by_tags])
  end

  def new
    @recipe = Recipe.new
  end

  def create
    recipe = Recipe.new(recipe_params)
    recipe.user = current_user
    if recipe.save
      recipe.create_coefficients_for_usda_ingredients
      recipe.meal_categories << MealCategory.where(id: params[:categories]) if params[:categories]
      recipe.meal_components << MealComponent.where(id: params[:components]) if params[:components]
      recipe.tags << tags_from_string(params[:tags]) if params[:tags]
      redirect_to recipes_path
    else
      render :new
    end
  end

  def edit
    @tags = @recipe.tags
  end

  def update
    @recipe.update_categories(MealCategory.where(id: params[:categories]))
    @recipe.update_components(MealComponent.where(id: params[:components]))
    @recipe.update_tags(tags_from_string(params[:tags]))
    if @recipe.update_attributes(recipe_params)
      @recipe.create_coefficients_for_usda_ingredients
      redirect_to recipes_path
    else
      render :edit
    end
  end

  def destroy
    tag_ids = @recipe.tags.map(&:id)
    if @recipe.try(:destroy)
      Tag.where(id: tag_ids).each do |tag|
        tag.destroy if tag.recipes.count == 0
      end
    end
    render json: { status: 'success' }
  end

  def nutrition_label
    ingredients = params[:ingredients]
    count = params[:count].to_i

    @serving_size = @calories = @cholesterol = @sodium = @carbohydrate =
      @fiber = @sugars = @protein = @fats = @saturated_fats = 0

    for i in count.times
      unit = ingredients[i.to_s][:unit]
      usda_id = ingredients[i.to_s][:usda_id]
      quantity = ingredients[i.to_s][:quantity]

      if unit == 'gram'
        coefficient = 1
      else
        coefficient = UsdaNutrientDatabase::Food.find_by(nutrient_databank_number: usda_id).weights.where(measurement_description: unit).first.gram_weight
      end
      quantity_in_grams = quantity.to_f * coefficient
      nutrients = UsdaNutrientDatabase::FoodsNutrient.where(nutrient_databank_number: usda_id)
      @serving_size += quantity_in_grams
      @calories += calculate_nutrient(nutrients, 'Energy', quantity_in_grams)
      @cholesterol += calculate_nutrient(nutrients, 'Cholesterol', quantity_in_grams)
      @sodium += calculate_nutrient(nutrients, 'Sodium, Na', quantity_in_grams)
      @carbohydrate += calculate_nutrient(nutrients, 'Carbohydrate, by difference', quantity_in_grams)
      @fiber += calculate_nutrient(nutrients, 'Fiber, total dietary', quantity_in_grams)
      @sugars += calculate_nutrient(nutrients, 'Sugars, total', quantity_in_grams)
      @protein += calculate_nutrient(nutrients, 'Protein', quantity_in_grams)
      @fats += calculate_nutrient(nutrients, 'Total lipid (fat)', quantity_in_grams)
      @saturated_fats += calculate_nutrient(nutrients, 'Fatty acids, total saturated', quantity_in_grams)
    end
    @amount_per_serving = '?'

    render pdf: 'file_name',
           template: 'recipes/nutrition_label.html.erb'
  end

  def calculate_nutrient(nutrients, name, quantity)
    nutrient = nutrients.includes(:nutrient).where(usda_nutrients: { nutrient_description: name }).first
    nutrient_value = nutrient ? nutrient.nutrient_value : 0
    nutrient_in_gram = nutrient_value / 100
    return nutrient_in_gram * quantity
  end

  def clone
    original_recipe = Recipe.find(params[:recipe_id])
    new_recipe = original_recipe.dup
    new_recipe.name += ' Copy'
    new_recipe.save
    original_recipe.ingredient_quantities.each do |iq|
      new_iq = iq.dup
      new_recipe.ingredient_quantities << new_iq
    end
    original_recipe.tags.each do |tag|
      new_recipe.tags << tag
    end
    original_recipe.meal_components.each do |c|
      new_recipe.meal_components << c
    end
    original_recipe.meal_categories.each do |c|
      new_recipe.meal_categories << c
    end
    redirect_to recipes_path
  end

  def filter_recipes
    category_ids = params[:categories] ? params[:categories] : []
    tags_ids = params[:tags] ? params[:tags] : []
    if params[:category_id].present?
      category_ids.push params[:category_id]
    elsif params[:tag_id].present?
      tags_ids.push params[:tag_id]
    end
    redirect_to recipes_path(by_categories: category_ids, by_tags: tags_ids)
  end

  def get_type_of_unit
    unit = Unit.find_by(id: params[:unit_id])
    render json: { type: unit.unit_type_id }
  end

  def get_autocomplete_items(parameters)
    items = active_record_get_autocomplete_items(parameters)
    items = items.where(user: current_user)
  end

  def get_recipe_by_id
    recipe = Recipe.find_by(id: params[:recipe_id])
    render json: { recipe: recipe }
  end

  def search_tags
    tags = current_user.tags.where('name ILIKE ?', "%#{params[:name]}%").pluck(:name)
    render json: { tags: tags }
  end

  private

  def tags_from_string(str)
    names = str.split(', ')
    tags_id = []
    names.each do |t|
      tags_id << Tag.find_or_create_by(name: t.downcase, user_id: current_user.id).id
    end
    Tag.where(id: tags_id)
  end

  def set_recipe
    @recipe = Recipe.find_by(id: params[:id])
  end

  def set_items_for_recipe
    @units = Unit.all.order(:unit_type_id)
    @meal_categories = MealCategory.all
    @meal_components = MealComponent.all
  end

  def recipe_params
    params.require(:recipe).permit(
      :name,
      :servings_count,
      :instruction,
      ingredient_quantities_attributes: [
        :id,
        :quantity,
        :ingredient_id,
        :recipe_id,
        :unit_id,
        :_destroy,
        ingredient_attributes: [
          :id,
          :name,
          :store,
          :user_id,
          :unit_type_id,
          :usda_id
        ]
      ]
    )
  end

  def filtering_params(params)
    params.slice(:by_tags, :by_categories)
  end
end
