class AddUserToTags < ActiveRecord::Migration
  def up
    add_reference :tags, :user, index: true, foreign_key: true, null: false
  end

  def down
    remove_reference :tags, :user
  end
end
