ActiveAdmin::Dashboards.build do

  # Define your dashboard sections here. Each block will be
  # rendered on the dashboard in the context of the view. So just
  # return the content which you would like to display.

  # == Simple Dashboard Section
  # Here is an example of a simple dashboard section
  #
  #   section "Recent Posts" do
  #     ul do
  #       Post.recent(5).collect do |post|
  #         li link_to(post.title, admin_post_path(post))
  #       end
  #     end
  #   end

  # == Render Partial Section
  # The block is rendered within the context of the view, so you can
  # easily render a partial rather than build content in ruby.
  #
  #   section "Recent Posts" do
  #     div do
  #       render 'recent_posts' # => this will render /app/views/admin/dashboard/_recent_posts.html.erb
  #     end
  #   end

  # == Section Ordering
  # The dashboard sections are ordered by a given priority from top left to
  # bottom right. The default priority is 10. By giving a section numerically lower
  # priority it will be sorted higher. For example:
  #
  #   section "Recent Posts", :priority => 10
  #   section "Recent User", :priority => 1
  #
  # Will render the "Recent Users" then the "Recent Posts" sections on the dashboard.

  section "Upcoming Appointments", :priority => 1 do
    near_appointments = Appointment.near_due.order("duedate asc").limit(10)
    table_for near_appointments.each do
      column("Date") { |appointment| pretty_format(appointment.duedate) }
      column("Location") { |appointment| appointment.location }
      column("Member") { |appointment| link_to(appointment.member.name, admin_member_path(appointment.member))}
      column("Description") { |appointment| link_to(snippet(appointment.body), admin_appointment_path(appointment)) }
    end unless near_appointments.empty?
  end

  section "Near Due Incomplete Goals", :priority => 2 do
    near_goals = Goal.near_due.incomplete.order("duedate asc").limit(10)
    table_for near_goals.each do
      column("Due Date") { |goal| pretty_format(goal.duedate.to_date) }
      column("Member") { |goal| link_to(goal.member.name, admin_member_path(goal.member))}
      column("Goal") { |goal| link_to(snippet(goal.body), admin_goal_path(goal)) }
    end unless near_goals.empty?
  end

  section "Recent Progress Notes", :priority => 3 do
    table_for Note.order('updated_at desc').limit(10).each do
      column("Date") { |note| pretty_format(note.updated_at.to_date) }
      column("Member") { |note| link_to(note.member.name, admin_member_path(note.member))}
      column("Note") { |note| link_to(snippet(note.body), admin_note_path(note)) }
    end
  end

  section "Incomplete Profiles", :priority => 4 do
    incomplete_members = Member.incomplete
    table_for incomplete_members.each do |member|
      column("Last Updated") { |member| pretty_format(member.updated_at.to_date) }
      column("Name") { |member| link_to(member.name, admin_member_path(member)) }
    end unless incomplete_members.empty?
  end

  # section "Recently Diagnosed Members", :priority => 2 do
  #   table_for Member.order('dateDiagnosis desc').limit(10).each do |member|
  #     column("Date") { |member| l(member.dateDiagnosis, :format => :long) }
  #     column("Name") { |member| link_to(member.firstName + " " + member.lastName, admin_member_path(member)) }
  #   end
  # end
end
