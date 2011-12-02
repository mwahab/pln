class AddDentistDoctorToMember < ActiveRecord::Migration
  def change
    add_column :members, :doctor, :string
    add_column :members, :doctorPhone, :string
    add_column :members, :dentist, :string
    add_column :members, :dentistPhone, :string
    add_column :members, :dateDiagnosis, :datetime
    add_column :members, :placeDiagnosis, :string
  end
end
