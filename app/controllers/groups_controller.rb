class GroupsController < ApplicationController
  before_action :set_group, only: [:show, :edit, :update, :destroy]
  before_action :set_items, only: [:new, :edit]

  def index
    @groups = current_user.groups
  end

  def new
    @group = Group.new
  end

  def create
    group = Group.new(group_params)
    group.user = current_user
    if group.save
      group.total_individuals = group.appetite_size_quantities.sum(:quantity)
      group.total_servings = 0
      group.appetite_sizes.each do |size|
        group.total_servings += group.appetite_size_quantities.find_by(appetite_size: size).quantity * size.coefficient
      end
      group.save

      redirect_to groups_path
    else
      render :new
    end
  end

  def edit
    @group_recipes = @group.recipes
    @recipes = @recipes - @group_recipes
  end

  def update
    if @group.update_attributes(group_params)
      redirect_to groups_path
    else
      render :edit
    end
  end

  def destroy
    @group.try(:destroy)
    render json: { status: 'success' }
  end

  def show
    @group_recipes = @group.recipe_quantities
    recipe_ingredients = RecipeIngredientsQuantity.where(recipe_id: @group.recipes.map(&:id))
    @ingredients = recipe_ingredients.map(&:ingredient).uniq
  end

  def filter_recipes
    categories = MealCategory.where(name: params[:categories])
    components = MealComponent.where(name: params[:components])
    recipes = current_user.recipes
    recipes = recipes.by_categories(categories.map(&:id)) if categories.present?
    recipes = recipes - recipes.by_components(components.map(&:id)) if components.present?
    render json: { recipes: recipes }
  end

  private

  def set_group
    @group = Group.find_by(id: params[:id])
  end

  def set_items
    @appetite_sizes = AppetiteSize.all
    @recipes = current_user.recipes.includes(:group_recipes_quantities).order('group_recipes_quantities.quantity')
    @components = MealComponent.all
    @categories = MealCategory.all
  end

  def group_params
    params.require(:group).permit(
      :name,
      :description,
      appetite_size_quantities_attributes: [
        :id,
        :quantity,
        :appetite_size_id,
        :group_id
      ],
      recipe_quantities_attributes: [
        :id,
        :quantity,
        :individuals_served,
        :recipe_id,
        :group_id,
        :_destroy
      ]
    )
  end
end
