class AddInactiveToMembers < ActiveRecord::Migration
  def change
    add_column :members, :active, :boolean
    add_column :members, :methadone, :boolean
  end
end
