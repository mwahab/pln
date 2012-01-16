class ChangeGoalCommenter < ActiveRecord::Migration
  def up
    remove_column :goals, :commenter
    add_column :goals, :admin_user_id, :integer
    add_index :goals, :admin_user_id
  end

  def down
    add_column :goals, :commenter, :string
    remove_column :goals, :admin_user_id
    remove_index :goals, :admin_user_id
  end
end
