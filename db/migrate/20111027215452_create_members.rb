class CreateMembers < ActiveRecord::Migration
  def change
    create_table :members do |t|
      t.string :firstName
      t.string :lastName
      t.datetime :birthdate
      t.string :gender
      t.string :address
      t.string :city
      t.string :province
      t.string :postalCode
      t.string :telephone
      t.string :carecard
      t.string :sin
      t.string :ethnicity
      t.string :diagnosis
      t.boolean :arv
      t.datetime :arvDate
      t.string :comments

      t.timestamps
    end
  end
end
