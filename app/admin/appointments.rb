ActiveAdmin.register Appointment do
  filter :member
  # filter :complete, :as => :select, :collection => [["Yes", true], ["No", false]]

  scope :all, :default => true
  scope :completed
  scope :incomplete

  index do
    column("Status", :sortable => :complete) {|appointment| status_tag(appointment.state)}    
    column "Member", :member, :sortable => false
    column "Date", :sortable => :duedate do |appointment|
      appointment.duedate ? pretty_format(appointment.duedate) : 'N/A'
    end
    column "Location", :location, :sortable => false
    column("Description", :body, :sortable => false) {|appointment| snippet(appointment.body)}
    default_actions
  end

  show :title => "" do
    attributes_table_for appointment do
      row("Member") { link_to(appointment.member.name, admin_member_path(appointment.member)) }      
      row("Status") { status_tag(appointment.state) }
      row("Date") { appointment.duedate ? pretty_format(appointment.duedate) : 'N/A' }
      row("Location") { appointment.location }      
      row("Description") { appointment.body }
      row("Updated By") { appointment.admin_user }      
      row("Created") { pretty_format(appointment.created_at) }
      row("Updated") { pretty_format(appointment.updated_at) }
    end
  end

  form :partial => "form"
end
