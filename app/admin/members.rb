ActiveAdmin.register Member do
  filter :gender, :as => :select, :collection => proc { Member::GENDERS } 
  filter :province, :as => :select, :collection => proc { Member::PROVINCES }
  filter :diagnosis, :as => :select, :collection => proc { Member::DIAGNOSES }
  filter :ethnicity, :as => :select, :collection => proc { Member::ETHNICITIES }
  filter :arv, :as => :select, :collection => [["Yes", true], ["No", false]]
  filter :methadone, :as => :select, :collection => [["Yes", true], ["No", false]]
  filter :active, :as => :select, :collection => [["Yes", true], ["No", false]]

  index do
    column :name
    column :birthdate, :sortable => :birthdate do |member|
      member.birthdate.to_date.to_s
    end
    column :gender
    column :city
    column :province
    column "Postal code", :postalCode
    column :ethnicity
    column :diagnosis
    column("ARV", :sortable => :arv) { |member| member.arv ? 'Yes' : 'No' }
    column("Methadone", :sortable => :methadone) { |member| member.methadone ? 'Yes' : 'No'}
    column("Active", :sortable => :active) { |member| member.active ? 'Yes' : 'No'}
    default_actions
  end

  show :title => "" do
    panel "Goals" do
      goals = member.goals.page(params[:goals_page]).per(5)
      table_for goals do
        column("Due Date") {|goal| goal.duedate ? pretty_format(goal.duedate.to_date) : '-'}
        column("Complete") {|goal| status_tag(goal.state)}
        column("Goal") {|goal| link_to(goal.body, admin_goal_path(goal))}
      end
      paginate goals, :param_name => :goals_page
    end

    panel "Progress Notes" do
      notes = member.notes.order("updated_at desc").page(params[:notes_page]).per(5)
      table_for notes do
        column("Date") { |note| pretty_format(note.updated_at.to_date) }
        column("Note") { |note| link_to(note.body, admin_note_path(note)) }
      end
      paginate notes, :param_name => :notes_page
    end
  end

  sidebar "Member Details", :only => :show do
    attributes_table_for member do
      row("Name") { member.name }
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
      row("Methadone") { member.methadone ? 'Yes' : 'No' }
      row("Doctor") { member.doctor }
      row("Doctor Telephone") { member.doctorPhone }
      row("Emergency Contact") { member.emergency_contact_name }
      row("Emergency Contact Telephone") { member.emergency_contact_phone }
      row("Active") { member.active ? 'Yes' : 'No' }
      row("Created") { l(member.created_at, :format => :long) }
      row("Updated") { l(member.updated_at, :format => :long) }
    end
  end

  form :partial => "form"
end
