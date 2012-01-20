class RemoveFirstNameFromMember < ActiveRecord::Migration
  def up
    remove_column :members, :firstName
    remove_column :members, :lastName
  end

  def down
    add_column :members, :firstName, :string
    add_column :members, :lastName, :string
  end
end
