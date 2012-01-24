jsonMembers =ActiveSupport::JSON.decode(File.read('members.json')).each do |m|
  if Time.parse(m["updated_at"]).year == 2012 
    Member.create!(:name => m["firstName"] + " " + m["lastName"],
                   :birthdate => m["birthdate"],
                   :gender => m["gender"],
                   :address => m["address"],
                   :city => m["city"],
                   :province => m["province"],
                   :postalCode => m["postalCode"],
                   :telephone => m["telephone"],
                   :carecard => m["carecard"],
                   :sin => m["sin"],
                   :ethnicity => m["ethnicity"],
                   :diagnosis => m["diagnosis"],
                   :arv => m["arv"],
                   :arvDate => m["arvDate"],
                   :methadone => m["methadone"],
                   :active => m["active"],
                   :doctor => m["doctor"],
                   :doctorPhone => m["doctorPhone"],
                   :emergency_contact_name => m["emergency_contact_name"],
                   :emergency_contact_phone => m["emergency_contact_phone"],
                   :dateDiagnosis => m["dateDiagnosis"],
                   :placeDiagnosis => m["placeDiagnosis"])
  end
end
