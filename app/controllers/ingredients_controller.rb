# Actions for ingredients page, actions for prices & other actions:
# get_ingredients_from_usda, find_ingredient
class IngredientsController < ApplicationController
  def index
    @ingredients = current_user.ingredients.order(:name).includes(:recipes)
    @recipes = current_user.recipes.order(:name)
    if params[:recipe_id].present?
      @ingredients = Recipe.find_by(id: params[:recipe_id]).ingredients
    end
  end

  def update_inventory
    params[:ingredients].each do |key, value|
      ingredient = Ingredient.find_by(id: key)
      ingredient.update_attributes(
        name: value[:name],
        note: value[:note],
        store: value[:store],
        usda_id: value[:usda_id]
      )
    end
    redirect_to ingredients_path
  end

  def create_price
    unit = Unit.find_by(id: params[:unit_id])
    ingredient = Ingredient.find_by(id: params[:ingredient_id])
    cost = IngredientUnitCost.find_by(
      unit_id: unit.id,
      ingredient_id: ingredient.id
    )
    if cost
      cost.price = params[:price]
      cost.save
    else
      IngredientUnitCost.create(
        unit_id: unit.id,
        ingredient_id: ingredient.id,
        price: params[:price])
    end
    respond_to do |format|
      format.html { redirect_to ingredients_path, notice: 'Price was successfully created.' }
      format.json { render :index, status: :created, location: ingredients_path }
    end
  end

  def get_price
    cost = IngredientUnitCost.find_by(
      unit_id: params[:unit_id],
      ingredient_id: params[:ingredient_id]
    )
    if cost
      render json: { price: cost.price }
    else
      render json: { price: 0 }
    end
  end

  def get_ingredients_from_usda
    ingredients = UsdaNutrientDatabase::Food.includes(:food_group)
    params[:name].split(' ').each do |word|
      ingredients = ingredients.where('short_description ILIKE ?', "%#{word}%")
    end
    render json: { food: ingredients.as_json(include: :food_group) }
  end

  def find_ingredient
    ingredient = Ingredient.user_id(params[:user_id]).name_is_like(params[:ingredient_name]).first
    render json: { ingredient: ingredient, units: ingredient.try(:unit_type).try(:units) }
  end
end
