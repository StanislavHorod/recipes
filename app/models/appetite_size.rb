# AppetiteSize model
class AppetiteSize < ActiveRecord::Base
  has_many :appetite_size_quantities, dependent: :destroy
  has_many :groups, through: :appetite_size_quantities

  validates_presence_of :name, :coefficient
end
