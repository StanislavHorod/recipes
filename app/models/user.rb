# User model
class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :recipes, dependent: :destroy
  has_many :ingredients, dependent: :destroy
  has_many :groups, dependent: :destroy
  has_many :tags, dependent: :destroy

  def name
    "#{first_name} #{last_name} (##{id})"
  end
end
