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
      member.birthdate.to_date.to_s if member.birthdate
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

  # action_item(:only => :show) do
  #   link_to "Add Goal", new_resource_path(member.goal)
  # end

  show :title => :name do

    member_completed_goals = member.goals.completed.order("duedate asc").page(params[:goals_completed_page]).per(10)
    member_incomplete_goals = member.goals.incomplete.order("duedate asc").page(params[:goals_incomplete_page]).per(10)

    panel "Completed Goals" do
      table_for member_completed_goals do
        column("Due Date") {|goal| goal.duedate ? pretty_format(goal.duedate.to_date) : 'N/A'}
        column("Status") {|goal| status_tag(goal.state)}
        column("Goal") {|goal| link_to(snippet(goal.body), admin_goal_path(goal))}
      end
      paginate member_completed_goals, :param_name => :goals_completed_page
    end unless member.goals.completed.count == 0

    panel "Incomplete Goals" do
      table_for member_incomplete_goals do
        column("Due Date") {|goal| goal.duedate ? pretty_format(goal.duedate.to_date) : 'N/A'}
        column("Status") {|goal| status_tag(goal.state)}
        column("Goal") {|goal| link_to(snippet(goal.body), admin_goal_path(goal))}
      end
      paginate member_incomplete_goals, :param_name => :goals_incomplete_page
    end unless member.goals.incomplete.count == 0

    panel "Progress Notes" do
      notes = member.notes.order("updated_at desc").page(params[:notes_page]).per(10)
      table_for notes do
        column("Date") { |note| pretty_format(note.updated_at.to_date) }
        column("Note") { |note| link_to(snippet(note.body), admin_note_path(note)) }
      end
      paginate notes, :param_name => :notes_page
    end
  end

  sidebar "Member Details", :only => :show do
    attributes_table_for member do
      row("Name") { member.name }
      row("Birthdate") { pretty_format(member.birthdate.to_date) if member.birthdate }
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
      row("Date of Diagnosis") { pretty_format(member.dateDiagnosis.to_date) if member.dateDiagnosis }
      row("Anti-Retrovirals") { member.arv ? 'Yes' : 'No' }
      if member.arv
        row("Anti-Retrovirals Since") { pretty_format(member.arvDate.to_date) if member.arvDate }
      end
      row("Methadone") { member.methadone ? 'Yes' : 'No' }
      row("Doctor") { member.doctor }
      row("Doctor Telephone") { member.doctorPhone }
      row("Emergency Contact") { member.emergency_contact_name }
      row("Emergency Contact Telephone") { member.emergency_contact_phone }
      row("Active") { member.active ? 'Yes' : 'No' }
      row("Created") { pretty_format(member.created_at) }
      row("Updated") { pretty_format(member.updated_at) }
    end
  end

  form :partial => "form"
end
