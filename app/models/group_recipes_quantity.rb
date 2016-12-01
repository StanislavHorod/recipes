class GroupRecipesQuantity < ActiveRecord::Base
  belongs_to :group
  belongs_to :recipe

  validates_presence_of :quantity
end
