class CreateAppointments < ActiveRecord::Migration
  def change
    create_table :appointments do |t|
      t.text :body
      t.datetime :duedate
      t.boolean :complete
      t.references :member
      t.integer :admin_user_id

      t.timestamps
    end
    add_index :appointments, :member_id
    add_index :appointments, :admin_user_id
  end
end
