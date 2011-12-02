class RemoveCommentsFromMember < ActiveRecord::Migration
  def up
    remove_column :members, :comments
  end

  def down
    add_column :members, :comments, :string
  end
end
