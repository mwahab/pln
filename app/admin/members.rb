ActiveAdmin.register Member do
  filter :gender, :as => :select, :collection => proc { Member::GENDERS } 
  filter :province, :as => :select, :collection => proc { Member::PROVINCES }
  filter :diagnosis, :as => :select, :collection => proc { Member::DIAGNOSES }
  filter :ethnicity, :as => :select, :collection => proc { Member::ETHNICITIES }
  filter :arv


  index do
    column "Family name", :lastName
    column "Given name", :firstName
    column :birthdate, :sortable => :birthdate do |member|
      member.birthdate.to_date.to_s
    end
    column :gender
    column :city
    column :province
    column "Postal code", :postalCode
    column :ethnicity
    column :diagnosis
    column "ARV?", :arv
    default_actions
  end

  show do
    panel "Member Details" do
      attributes_table_for member do
        row("Name") { member.firstName + " " + member.lastName }
        row("Birthdate") { l(member.birthdate, :format => :long) if member.birthdate }
        row("Gender") { member.gender }
        row("Address") { member.address }
        row("City") { member.city }
        row("Province") { member.province }
        row("Telephone") { member.telephone }
        row("Carecard #") { member.carecard }
        row("Social Insurance #") { member.sin }
        row("Ethnicity") { member.ethnicity }
        row("Diagnosis") { member.diagnosis }
        row("Place of Diagnosis") { member.placeDiagnosis }
        row("Date of Diagnosis") { l(member.dateDiagnosis, :format => :long) if member.dateDiagnosis }
        row("Anti-Retrovirals") { member.arv ? 'Yes' : 'No' }
        if member.arv
          row("Anti-Retrovirals Since") { l(member.arvDate, :format => :long) if member.arvDate }
        end
        row("Doctor") { member.doctor }
        row("Doctor Telephone") { member.doctorPhone }
        row("Dentist") { member.dentist }
        row("Dentist Telephone") { member.dentistPhone }
        row("Created") { l(member.created_at, :format => :long) }
        row("Updated") { l(member.updated_at, :format => :long) }
      end
    end
    active_admin_comments
  end

  form :partial => "form"
end
