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

  section "Near Due Incomplete Goals", :priority => 1 do
    table_for Goal.near_due.incomplete.order("duedate asc").limit(10).each do
      column("Due Date") { |goal| pretty_format(goal.duedate.to_date) }
      column("Member") { |goal| link_to(goal.member.name, admin_member_path(goal.member))}
      column("Goal") { |goal| link_to(snippet(goal.body), admin_goal_path(goal)) }
    end
  end unless Goal.near_due.count == 0

  section "Recent Progress Notes", :priority => 2 do
    table_for Note.order('updated_at desc').limit(10).each do
      column("Date") { |note| pretty_format(note.updated_at.to_date) }
      column("Member") { |note| link_to(note.member.name, admin_member_path(note.member))}
      column("Note") { |note| link_to(snippet(note.body), admin_note_path(note)) }
    end
  end unless Note.count == 0

  section "Incomplete Profiles", :priority => 3 do
    table_for Member.incomplete_files.each do |member|
      column("Last Updated") { |member| pretty_format(member.updated_at.to_date) }
      column("Name") { |member| link_to(member.name, admin_member_path(member)) }
    end
  end unless Member.incomplete_files.count == 0

  # section "Recently Diagnosed Members", :priority => 2 do
  #   table_for Member.order('dateDiagnosis desc').limit(10).each do |member|
  #     column("Date") { |member| l(member.dateDiagnosis, :format => :long) }
  #     column("Name") { |member| link_to(member.firstName + " " + member.lastName, admin_member_path(member)) }
  #   end
  # end

end
