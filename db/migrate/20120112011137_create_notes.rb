class CreateNotes < ActiveRecord::Migration
  def change
    create_table :notes do |t|
      t.string :commenter
      t.text :body
      t.references :member

      t.timestamps
    end
    add_index :notes, :member_id
  end
end
