class AddLocationToAppointment < ActiveRecord::Migration
  def change
    change_table :appointments do |t|
      t.string :location
    end
  end
end
