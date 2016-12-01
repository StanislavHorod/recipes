# The quantity of each appetite size in each group
class AppetiteSizeQuantity < ActiveRecord::Base
  belongs_to :appetite_size
  belongs_to :group

  validates_presence_of :quantity
end
