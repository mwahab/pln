class ChangeNoteCommenter < ActiveRecord::Migration
  def up
    remove_column :notes, :commenter
    add_column :notes, :admin_user_id, :integer
    add_index :notes, :admin_user_id
  end

  def down
    add_column :notes, :commenter, :string
    remove_column :notes, :admin_user_id
    remove_index :notes, :admin_user_id
  end
end
