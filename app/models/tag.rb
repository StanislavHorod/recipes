# Tag model
class Tag < ActiveRecord::Base
  has_and_belongs_to_many :recipes
  belongs_to :user
end
