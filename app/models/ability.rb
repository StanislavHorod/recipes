# Model for CanCan
class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new
    if user.new_record?
      cannot :manage, :all
    else
      can :manage, Recipe, user_id: user.id
      # can :manage, Ingredient, user_id: user.id
      # can :manage, Group, user_id: user.id
    end
  end
end
