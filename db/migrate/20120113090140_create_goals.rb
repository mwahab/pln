class CreateGoals < ActiveRecord::Migration
  def change
    create_table :goals do |t|
      t.string :commenter
      t.text :body
      t.datetime :duedate
      t.boolean :complete
      t.references :member

      t.timestamps
    end
    add_index :goals, :member_id
  end
end
